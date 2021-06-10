Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F39503A300D
	for <lists+linux-fpga@lfdr.de>; Thu, 10 Jun 2021 18:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbhFJQF7 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 10 Jun 2021 12:05:59 -0400
Received: from mail-oi1-f175.google.com ([209.85.167.175]:43743 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbhFJQF6 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 10 Jun 2021 12:05:58 -0400
Received: by mail-oi1-f175.google.com with SMTP id x196so2635595oif.10;
        Thu, 10 Jun 2021 09:03:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a5oo7TWTKnejB/NSyi1wnjYclDhZO0+JNnZ0T3JYfKU=;
        b=DlbuS8U5MRTOzvFc2JjRWFzKkFWP8RUQNJYHATdP69KNi1rsuT3UsecltxNkJcaNy0
         yAof0hJjP0n7hxwpo+LqnV4IAfFPfzHAyP/O7uKyK1FHCtek24TQdEH/phxXH3rtsa1n
         au09HfOkpJkv11OzV7Cm6Gc70/1GgVYByLUqGnxuWpBoPPBx9sV20l091YwVn9fue08B
         0q5JuuhyXqF5LDX9W7sK3TXrUpEcODRMJSEhMnsa/v23akxSjrDiptAj0B0LwqmfvK0D
         ArgAXd7tsjXdrQpBp+inur5EDvX0XNnUDOpEe/EgJrOsTT+MwUxo89WQB3gjRNMiBz/I
         dD3w==
X-Gm-Message-State: AOAM530z8Jc3FDITL5I2WRdhvfnmU3xvvkAS9Lgn//o2tri2xQf6X/eU
        l8npocA2huPgZg4ay+bt3A==
X-Google-Smtp-Source: ABdhPJxwAL0yW2ShIIl0STCx2/tb/hEmiPJpgxZ2+n9NW7+yPvslHVmkAwQwapoq9KYASfSAdmTouA==
X-Received: by 2002:aca:ac47:: with SMTP id v68mr3958872oie.160.1623341026947;
        Thu, 10 Jun 2021 09:03:46 -0700 (PDT)
Received: from robh.at.kernel.org ([172.58.99.113])
        by smtp.gmail.com with ESMTPSA id h1sm675077otq.59.2021.06.10.09.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 09:03:46 -0700 (PDT)
Received: (nullmailer pid 1890719 invoked by uid 1000);
        Thu, 10 Jun 2021 16:03:42 -0000
Date:   Thu, 10 Jun 2021 11:03:42 -0500
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
Subject: Re: [PATCH v7 3/4] dt-bindings: firmware: Add bindings for xilinx
 firmware
Message-ID: <20210610160342.GA1883933@robh.at.kernel.org>
References: <20210604113332.1394-1-nava.manne@xilinx.com>
 <20210604113332.1394-4-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604113332.1394-4-nava.manne@xilinx.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, Jun 04, 2021 at 05:03:31PM +0530, Nava kishore Manne wrote:
> Add documentation to describe Xilinx firmware driver bindings.
> Firmware driver provides an interface to firmware APIs.
> Interface APIs can be used by any driver to communicate
> to Platform Management Unit.
> 
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> ---
> Changes for v4:
>               -Added new yaml file for xilinx firmware
>                as suggested by Rob.
> 
> Changes for v5:
>               -Fixed some minor issues and updated the fpga node name to versal_fpga.
> 
> Changes for v6:
>               -Added AES and Clk nodes as a sub nodes to the firmware node.
> 
> Changes for v7:
>               -Fixed child nodes format ssues.
> 
>  .../firmware/xilinx/xlnx,zynqmp-firmware.yaml | 94 +++++++++++++++++++
>  1 file changed, 94 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml

You need to remove xlnx,zynqmp-firmware.txt

> 
> diff --git a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
> new file mode 100644
> index 000000000000..8e0241c4c137
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
> @@ -0,0 +1,94 @@
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
> +  "versal_fpga":

Don't need quotes

> +    $ref: /schemas/fpga/xlnx,versal-fpga.yaml#
> +    description: Compatible of the FPGA device.
> +    type: object
> +
> +  "zynqmp-aes":

Don't need quotes

> +    $ref: /schemas/crypto/xlnx,zynqmp-aes.yaml#
> +    description: |
> +                 The ZynqMP AES-GCM hardened cryptographic accelerator is
> +                 used to encrypt or decrypt the data with provided key and
> +                 initialization vector.

Don't need '|' here (there's no formatting) and indent 2 more than 
'description'.

> +    type: object
> +
> +  "clock-controller":
> +    $ref: /schemas/clock/xlnx,versal-clk.yaml#
> +    description: |
> +                 The clock controller is a hardware block of Xilinx versal
> +                 clock tree. It reads required input clock frequencies from
> +                 the devicetree and acts as clock provider for all clock
> +                 consumers of PS clocks.list of clock specifiers which are
> +                 external input clocks to the given clock controller.
> +    type: object
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
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
> +...
> -- 
> 2.17.1
