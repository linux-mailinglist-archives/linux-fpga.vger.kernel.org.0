Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84C40399291
	for <lists+linux-fpga@lfdr.de>; Wed,  2 Jun 2021 20:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbhFBSdS (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 2 Jun 2021 14:33:18 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43]:37799 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhFBSdR (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 2 Jun 2021 14:33:17 -0400
Received: by mail-ot1-f43.google.com with SMTP id v19-20020a0568301413b0290304f00e3d88so3322635otp.4;
        Wed, 02 Jun 2021 11:31:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xNv/f0yGewnLaU3I+RiefLup5Xbu0BrnltZhfOfNrR8=;
        b=XaMha0fpVfI58nBqFNayhN5FH3Ec2XpiHpYN7ZaAJZBcCnHuOVmwqhgiYZxHc79aaC
         ussXlSS0Yhw3dNsVlHH/DJ7RVkhS4Bcm87sEd6y4JWyeoGUH/wVdZ3V2pAY/yX+h5a3G
         0lS+QwX4xnsgCTB0tyBe+bYQNkMLgC7bahNH4zmFT+wETzw26ZZghXloQdxyh16z9toL
         uPuv//Zm2vqu1UOhdSqWMalnW/XdyI5S3cZg4Tf257fa2ftrExZ2ZF3EnqHQ8D3HNw7p
         xW0j1IZpxdHnlZpSyl5qR4/tpyIwjlwWhik097JbmW/uXeTZnkDEvONfeGDcXD/hPGPk
         HxFw==
X-Gm-Message-State: AOAM53145yRbCA+ZjWqFQ9SWHmOyqLnHTebqIzpih/lDUzHYwP/asW6B
        eHH+gk6RQv3nRsbW6hCxug==
X-Google-Smtp-Source: ABdhPJxT5ly8mROTCoKPXZI8f9WJIYY58jIsA0SbGshEauacWNHu+uhVDukcwe0VEasg8RghvDj+Rw==
X-Received: by 2002:a9d:7410:: with SMTP id n16mr26939586otk.262.1622658693744;
        Wed, 02 Jun 2021 11:31:33 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t4sm135952ool.41.2021.06.02.11.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 11:31:32 -0700 (PDT)
Received: (nullmailer pid 3730165 invoked by uid 1000);
        Wed, 02 Jun 2021 18:31:31 -0000
Date:   Wed, 2 Jun 2021 13:31:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nava kishore Manne <nava.manne@xilinx.com>
Cc:     michal.simek@xilinx.com, mdf@kernel.org, trix@redhat.com,
        arnd@arndb.de, rajan.vaja@xilinx.com, gregkh@linuxfoundation.org,
        amit.sunil.dhamne@xilinx.com, tejas.patel@xilinx.com,
        zou_wei@huawei.com, lakshmi.sai.krishna.potthuri@xilinx.com,
        ravi.patel@xilinx.com, iwamatsu@nigauri.org,
        wendy.liang@xilinx.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org, git@xilinx.com,
        chinnikishore369@gmail.com
Subject: Re: [PATCH v6 3/4] dt-bindings: firmware: Add bindings for xilinx
 firmware
Message-ID: <20210602183131.GA3706177@robh.at.kernel.org>
References: <20210520080954.1393-1-nava.manne@xilinx.com>
 <20210520080954.1393-4-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210520080954.1393-4-nava.manne@xilinx.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, May 20, 2021 at 01:39:53PM +0530, Nava kishore Manne wrote:
> Add documentation to describe Xilinx firmware driver bindings.
> Firmware driver provides an interface to firmware APIs.
> Interface APIs can be used by any driver to communicate
> to Platform Management Unit.
> 
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> ---
> Changes for v4:
>                 -Added new yaml file for xilinx firmware
>                  as suggested by Rob.
> Changes for v5:
>                 -Fixed some minor issues and updated the fpga node name to versal_fpga.
> 
> Changes for v6:
>                -Added AES and Clk nodes as a sub nodes to the firmware node.
> 
>  .../firmware/xilinx/xlnx,zynqmp-firmware.yaml | 102 ++++++++++++++++++
>  1 file changed, 102 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
> 
> diff --git a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
> new file mode 100644
> index 000000000000..58016191e150
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
> @@ -0,0 +1,102 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/firmware/xilinx/xlnx,zynqmp-firmware.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Xilinx firmware driver
> +
> +maintainers:
> +  - Nava kishore Manne <nava.manne@xilinx.com>
> +
> +description:
> +  The zynqmp-firmware node describes the interface to platform firmware.
> +  ZynqMP has an interface to communicate with secure firmware. Firmware
> +  driver provides an interface to firmware APIs. Interface APIs can be
> +  used by any driver to communicate to PMUFW(Platform Management Unit).
> +  These requests include clock management, pin control, device control,
> +  power management service, FPGA service and other platform management
> +  services.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - description:
> +          For implementations complying for Zynq Ultrascale+ MPSoC.
> +        const: xlnx,zynqmp-firmware
> +
> +      - description:
> +          For implementations complying for Versal.
> +        const: xlnx,versal-firmware
> +
> +  method:
> +    description: |
> +                 The method of calling the PM-API firmware layer.
> +                 Permitted values are.
> +                 - "smc" : SMC #0, following the SMCCC
> +                 - "hvc" : HVC #0, following the SMCCC
> +
> +    $ref: /schemas/types.yaml#/definitions/string-array
> +    enum:
> +      - smc
> +      - hvc
> +
> +patternProperties:
> +  "versal_fpga":

This says 'fooversal_fpgabar' is a valid node name.

You don't need a pattern, move under 'properties'. Same for the other 
child nodes.

> +    $ref: "../../fpga/xlnx,versal-fpga.yaml#"

/schemas/fpga/...

Don't need quotes.

> +    description: Compatible of the FPGA device.
> +    type: object
> +    required:
> +      - compatible

Drop. What's required should be in xlnx,versal-fpga.yaml.

> +
> +  "zynqmp-aes":

Same comments as above on the rest of the child nodes.

> +    $ref: "../../crypto/xlnx,zynqmp-aes.yaml#"
> +    description: |
> +                 The ZynqMP AES-GCM hardened cryptographic accelerator is
> +                 used to encrypt or decrypt the data with provided key and
> +                 initialization vector.
> +    type: object
> +    required:
> +      - compatible
> +
> +  "clock-controller":
> +    $ref: "../../clock/xlnx,versal-clk.yaml#"
> +    description: |
> +                 The clock controller is a hardware block of Xilinx versal
> +                 clock tree. It reads required input clock frequencies from
> +                 the devicetree and acts as clock provider for all clock
> +                 consumers of PS clocks.list of clock specifiers which are
> +                 external input clocks to the given clock controller.
> +    type: object
> +    required:
> +      - compatible
> +      - "#clock-cells"
> +      - clocks
> +      - clock-names
> +
> +required:
> +  - compatible
> +
> +examples:
> +  - |
> +    versal-firmware {
> +      compatible = "xlnx,versal-firmware";
> +      method = "smc";
> +
> +      versal_fpga: versal_fpga {
> +        compatible = "xlnx,versal-fpga";
> +      };
> +
> +      xlnx_aes: zynqmp-aes {
> +        compatible = "xlnx,zynqmp-aes";
> +      };
> +
> +      versal_clk: clock-controller {
> +        #clock-cells = <1>;
> +        compatible = "xlnx,versal-clk";
> +        clocks = <&ref>, <&alt_ref>, <&pl_alt_ref>;
> +        clock-names = "ref", "alt_ref", "pl_alt_ref";
> +      };
> +    };
> +
> +additionalProperties: false

Move this before the example.
