Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F88A488B6D
	for <lists+linux-fpga@lfdr.de>; Sun,  9 Jan 2022 18:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234564AbiAIRq5 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 9 Jan 2022 12:46:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:33547 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234538AbiAIRq4 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 9 Jan 2022 12:46:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641750416;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/m0DGCCGgJDWa2WsJaVc+ekN3fltbDLow+eopcpVs/g=;
        b=azD3afQbwLNK8HfM8H4m4aKg4xQex8rjpPAPLhANryTGTJn2npSNQFp894b7WTfO+HG7g0
        00CBXmzOU31Mm6pkcJxgg/pSIllLlf1ZsTvr8Ug1YtzStbu5TKk1tDu4PKF6rlgWnK14SY
        rA6Fk1SVCjJIzrRPvr0FCXyjpJMa69w=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-537--PGvHXM1OmCsST5KbJk1QQ-1; Sun, 09 Jan 2022 12:46:55 -0500
X-MC-Unique: -PGvHXM1OmCsST5KbJk1QQ-1
Received: by mail-oo1-f70.google.com with SMTP id p3-20020a4a4803000000b002da84ca8abcso7736925ooa.14
        for <linux-fpga@vger.kernel.org>; Sun, 09 Jan 2022 09:46:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=/m0DGCCGgJDWa2WsJaVc+ekN3fltbDLow+eopcpVs/g=;
        b=k5PUJb9+UHSK7EHtK8HiLt0tamajGyO4x09DKIzGAa54RmJdSAimDwXd8wUQ19gdOm
         8bYd4yIr85ni329lg9EyOU/8ssU1D+MKQIEAOBQUQabSW8Rm8F0KJARY92ICqezBB5DX
         MTqWnpRj+Mwf90Bd6OuAPJWd7cyRYRaGAG/rgJQK/n5k51Pv4n9gCRgvwtX5qNT7/cna
         mrpxE2NNGox15QEeAhHyTAT5ARHKN4bCNjr5clhe7QBL9lT7YJ75pdW5TQ+sm5ywwEjA
         n1gkNEfxOinyONb4PJPpZWW4sekkMqNqVTVEdACvayAL6K6wWvqNycoZbVh2oAxhaSGM
         mI5g==
X-Gm-Message-State: AOAM530BvV/A/5+Dg7kaAABfn2tM+E3aCqj25EBQ9tTOX0RbvtHfJd0f
        Hj/GjTtl8IW7Y+YyekV0S3rP96HuhuOk36MDEUdzpyC5bGxBgFCul1TQ5jofZb5wTkjeHLv3C0X
        irfcYu8IWqWZzXE30Vvnz0w==
X-Received: by 2002:a05:6808:1201:: with SMTP id a1mr16245635oil.153.1641750414371;
        Sun, 09 Jan 2022 09:46:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJweDPl4PyHuvvuqinIq0jaAq2rNaiCsPD4uGdY/3qNKroGAOcF1Z+Angfs9zypXlyhd8U5DOw==
X-Received: by 2002:a05:6808:1201:: with SMTP id a1mr16245611oil.153.1641750414074;
        Sun, 09 Jan 2022 09:46:54 -0800 (PST)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id q65sm789210oih.45.2022.01.09.09.46.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Jan 2022 09:46:53 -0800 (PST)
Subject: Re: [PATCH V4 XRT Alveo Infrastructure 2/5] Documentation:
 devicetree: bindings: add binding for Alveo platform
To:     Lizhi Hou <lizhi.hou@xilinx.com>, linux-kernel@vger.kernel.org
Cc:     linux-fpga@vger.kernel.org, maxz@xilinx.com,
        sonal.santan@xilinx.com, yliu@xilinx.com, michal.simek@xilinx.com,
        stefanos@xilinx.com, devicetree@vger.kernel.org, mdf@kernel.org,
        robh@kernel.org, dwmw2@infradead.org,
        Max Zhen <max.zhen@xilinx.com>
References: <20220105225013.1567871-1-lizhi.hou@xilinx.com>
 <20220105225013.1567871-3-lizhi.hou@xilinx.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <41c78998-d308-b23d-7b0e-9b668227f251@redhat.com>
Date:   Sun, 9 Jan 2022 09:46:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220105225013.1567871-3-lizhi.hou@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 1/5/22 2:50 PM, Lizhi Hou wrote:
> Create device tree binding document for partitions and pr isolation on
> Xilinx Alveo platform.
>
> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
> ---
>   .../bindings/fpga/xlnx,alveo-partition.yaml   | 76 +++++++++++++++++++
>   .../fpga/xlnx,alveo-pr-isolation.yaml         | 40 ++++++++++
>   2 files changed, 116 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,alveo-partition.yaml
>   create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,alveo-pr-isolation.yaml
>
> diff --git a/Documentation/devicetree/bindings/fpga/xlnx,alveo-partition.yaml b/Documentation/devicetree/bindings/fpga/xlnx,alveo-partition.yaml
> new file mode 100644
> index 000000000000..ee50cb51d08e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/fpga/xlnx,alveo-partition.yaml
> @@ -0,0 +1,76 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/fpga/xlnx,alveo-partition.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Xilinx Alveo platform partition bindings
> +
> +description: |
> +  Xilinx Alveo platform is a PCI device and has one or more partitions. A
PCIe
> +  partition is programmed dynamically and contains a set of hardware
> +  peripherals also referred to as endpoints which appear on the PCI BARs.
> +  This binding is defined for endpoint address translation which uses the
> +  the following encoding:
> +
> +    0xIooooooo 0xoooooooo
> +
> +  Where:
> +
> +    I = BAR index
> +    oooooo oooooooo = BAR offset
> +
> +  As a PCI device, the Alveo platform is enumerated at runtime. Thus,
> +  the partition node is created by Alveo device driver. The device driver
> +  gets the BAR base address of the PCI device and creates the 'range'
> +  property for address translation.
> +
> +allOf:
> +  - $ref: /schemas/simple-bus.yaml#
> +
> +maintainers:
> +  - Lizhi Hou <lizhi.hou@xilinx.com>
> +
> +properties:
> +  compatible:
> +    contains:
> +      const: xlnx,alveo-partition
> +
> +  "#address-cells":
> +    const: 2
> +
> +  "#size-cells":
> +    const: 2
> +
> +  ranges: true
> +
> +patternProperties:
> +  "^.*@[0-9a-f]+$":
> +    description: hardware endpoints belong to this partition.
> +    type: object
> +
> +required:
> +  - compatible
> +  - "#address-cells"
> +  - "#size-cells"
> +  - ranges
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    bus {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +        xrt-part-bus@0 {
> +            compatible = "xlnx,alveo-partition", "simple-bus";
> +            #address-cells = <2>;
> +            #size-cells = <2>;
> +            ranges = <0x0 0x0 0x0 0xe0000000 0x0 0x2000000
> +                      0x20000000 0x0 0x0 0xe4200000 0x0 0x40000>;
> +            pr-isolate-ulp@41000 {
> +                compatible = "xlnx,alveo-pr-isolation";
> +                reg = <0x0 0x41000 0 0x1000>;
> +            };
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/fpga/xlnx,alveo-pr-isolation.yaml b/Documentation/devicetree/bindings/fpga/xlnx,alveo-pr-isolation.yaml
> new file mode 100644
> index 000000000000..8db949093ee0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/fpga/xlnx,alveo-pr-isolation.yaml
> @@ -0,0 +1,40 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/fpga/xlnx,alveo-pr-isolation.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Xilinx Partial Reconfig Isolation for Alveo platforms
Expand 'Partial Reconfig' to 'Partial Reconfiguration'
> +
> +description: |
> +  The Partial Reconfig ensures glitch free operation of the inputs from
> +  a reconfigurable partition during partial reconfiguration on Alveo
> +  platform.

glitch free is not descriptive. maybe describe what that reg is used for.

Tom

> +
> +maintainers:
> +  - Lizhi Hou <lizhi.hou@xilinx.com>
> +
> +properties:
> +  compatible:
> +    const: xlnx,alveo-pr-isolation
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    bus {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        pr-isolation-ulp@41000 {
> +            compatible = "xlnx,alveo-pr-isolation";
> +            reg = <0 0x41000 0 0x1000>;
> +        };
> +    };

