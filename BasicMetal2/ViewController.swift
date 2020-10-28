//
//  ViewController.swift
//  BasicMetal2
//
//  Created by Appnap WS01 on 28/10/20.
//

import UIKit
import MetalKit
class ViewController: UIViewController {

    
    var pipelineState: MTLRenderPipelineState?
    var vertexBuffer: MTLBuffer?
    var vertices: [Float] = [
                                1,1,0,
                                -1,1,0,
                                1,0,0
                            ]
    
    var device: MTLDevice!
    var commandQueue: MTLCommandQueue!
    var metalView: MTKView {
        return view as! MTKView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        metalView.device = MTLCreateSystemDefaultDevice()
        device = metalView.device
        metalView.clearColor = MTLClearColor(red: 0.5, green: 0.2, blue: 0.7, alpha: 1)
        commandQueue = device.makeCommandQueue()
        metalView.delegate = self
        buildModel()
        buildPipelineSate()
    }
    
    private func buildModel() {
        vertexBuffer = device.makeBuffer(bytes: vertices, length: vertices.count * MemoryLayout<Float>.size, options: [])
    }
    
    private func buildPipelineSate() {
        let library = device.makeDefaultLibrary()
        let vertexFunction = library?.makeFunction(name: "vertex_shader")
        let fragmentFunction = library?.makeFunction(name: "fragment_shader")
        let descriptor = MTLRenderPipelineDescriptor()
        descriptor.vertexFunction = vertexFunction
        descriptor.fragmentFunction = fragmentFunction
        descriptor.colorAttachments[0].pixelFormat = .bgra8Unorm
        
        do {
            pipelineState = try device.makeRenderPipelineState(descriptor: descriptor)
        }catch {
            print(error)
        }
    }
    
}

extension ViewController: MTKViewDelegate {

    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        
    }
    
    func draw(in view: MTKView) {
        guard let drawable = view.currentDrawable, let descriptor = view.currentRenderPassDescriptor else { return }
        let commandBuffer = commandQueue.makeCommandBuffer()
        let commandEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: descriptor)
        commandEncoder?.setRenderPipelineState(pipelineState!)
        commandEncoder?.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        commandEncoder?.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: vertices.count)
        commandEncoder?.endEncoding()
        
        
        commandBuffer?.present(drawable)
        commandBuffer?.commit()
        
    }
    
    
}

