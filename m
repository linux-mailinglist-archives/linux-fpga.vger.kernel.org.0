Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D96E437015F
	for <lists+linux-fpga@lfdr.de>; Fri, 30 Apr 2021 21:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232910AbhD3Tkx (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 30 Apr 2021 15:40:53 -0400
Received: from mail-oi1-f171.google.com ([209.85.167.171]:41925 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232813AbhD3Tkw (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 30 Apr 2021 15:40:52 -0400
Received: by mail-oi1-f171.google.com with SMTP id i11so9116038oig.8;
        Fri, 30 Apr 2021 12:40:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oRTCLLrLVLX1YzXLCpau0W/3eis7qio3LTfXUrFMGeA=;
        b=YVKiR0XqczB9ByD1FQJRlGrqOh2QoSeBWG2db4p0E6HHTbexbzmU2LqDJV0/X2D7q3
         ZExC2BthHh4U2+MEJBfwB6ikmZo+7o/lN7Q7Y9rS5CeHn+chSx9vyv+gotp4KOWmJcFn
         Oi1lKFMe01x/R/xnUnWsYwJ0vwoeoubqKl6fJ5eScXjjE69lA/8B9sxm0BkurIYiFgVC
         izT0K7oXY0QY5BhgxBln1pBjz7poRzCBtul+sQ2qLDsftXWoqmhuuHtceTsTk28xCfb1
         bZmzVyaWECbKl4ebWiaEh5t9nu9xhdDOa9BmFIQ7qiYBAZ3uzqGvWOi2LYk2YJUwYQV/
         tC6A==
X-Gm-Message-State: AOAM531N/OEGO87lNOvlQC3dyv1J003G8mPCVdfRJsaX020yEZNKVM+p
        OoWXbLScfCfS/5X8Gc+pdA==
X-Google-Smtp-Source: ABdhPJx6E2XvFlAmdZxj8E8iaeTBP64l5MeiyFxM/eFPrfNxlgKWgdl2oMxZphJvRjvi30v4ahnJig==
X-Received: by 2002:aca:4056:: with SMTP id n83mr12485002oia.47.1619811603100;
        Fri, 30 Apr 2021 12:40:03 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t84sm983409oih.35.2021.04.30.12.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 12:40:02 -0700 (PDT)
Received: (nullmailer pid 3752697 invoked by uid 1000);
        Fri, 30 Apr 2021 19:40:00 -0000
Date:   Fri, 30 Apr 2021 14:40:00 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nava kishore Manne <nava.manne@xilinx.com>
Cc:     michal.simek@xilinx.com, mdf@kernel.org, trix@redhat.com,
        gregkh@linuxfoundation.org, arnd@arndb.de, rajan.vaja@xilinx.com,
        amit.sunil.dhamne@xilinx.com, manish.narani@xilinx.com,
        zou_wei@huawei.com, lakshmi.sai.krishna.potthuri@xilinx.com,
        iwamatsu@nigauri.org, wendy.liang@xilinx.com,
        linus.walleij@linaro.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org, chinnikishore369@gmail.com,
        git@xilinx.com
Subject: Re: [PATCH v4 1/4] dt-bindings: firmware: Add bindings for xilinx
 firmware
Message-ID: <20210430194000.GA3742101@robh.at.kernel.org>
References: <20210429140408.23194-1-nava.manne@xilinx.com>
 <20210429140408.23194-2-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210429140408.23194-2-nava.manne@xilinx.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, Apr 29, 2021 at 07:34:05PM +0530, Nava kishore Manne wrote:
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
> 
>  .../firmware/xilinx/xlnx,zynqmp-firmware.yaml | 63 +++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml

What about the old doc?:

Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt

> 
> diff --git a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
> new file mode 100644
> index 000000000000..4b97f005bed7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
> @@ -0,0 +1,63 @@
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
> +    description: The method of calling the PM-API firmware layer.
> +                #  Permitted values are:
> +                #  - "smc" : SMC #0, following the SMCCC
> +                #  - "hvc" : HVC #0, following the SMCCC

Drop the '#'. If you want to maintain the formatting, then use '|' after 
'description:' for a literal block.

> +    $ref: /schemas/types.yaml#/definitions/string-array
> +    enum:
> +      - smc
> +      - hvc
> +
> +patternProperties:
> +  "fpga":

So 'foofpgabar' is valid?

> +    description: Compatible of the FPGA device.
> +    type: object
> +
> +    required:
> +      - compatible

This belongs in the fpga schema which should have a $ref here. (Which 
means this patch needs to come 2nd.)

> +
> +required:
> +  - compatible
> +
> +examples:
> +  - |
> +    versal-firmware {
> +      compatible = "xlnx,versal-firmware";
> +      method = "smc";
> +      fpga {
> +        compatible = "xlnx,versal-fpga";
> +      };
> +    };
> +
> +additionalProperties: false
> -- 
> 2.17.1
> 
