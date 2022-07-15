Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71166575EAB
	for <lists+linux-fpga@lfdr.de>; Fri, 15 Jul 2022 11:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233280AbiGOJeP (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 15 Jul 2022 05:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232678AbiGOJeB (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 15 Jul 2022 05:34:01 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C811527143
        for <linux-fpga@vger.kernel.org>; Fri, 15 Jul 2022 02:33:59 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id bf9so6887583lfb.13
        for <linux-fpga@vger.kernel.org>; Fri, 15 Jul 2022 02:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=LWs7AqRcsJIuTaEyljmzXxNtVa28ecrdNGzJsWNp11U=;
        b=ccbbBpBHnHt320KqP5R2MNVZdv9btGA2pa5tLrgDv3xqrF6qYAhVNpkdVbm8drs9mC
         aygiC9IhevQ/w9zYa443tkCPgJHhpyUbcRO/imGQcjw4EFqiYDN7qtWkhZSl9Il6IBYz
         EUrWfosTDV3GDXXowzRyDFA/gBBuGjnIrdXmf73VkXnj9UEU4Oh/b741OR8p9AVNbOpu
         Gn3Hrrr4SOLXGUesNK07aogLzuBgYGnne1eXzsa38WOMv6wqxHEE/i9CR5RvHNMxX4ku
         eTAh11ZijzVzl+OOX9/QTnELt6b7W8i/kYnBKXSiM5OpH/T7nbv9BrlhDZHkfmPqbeq1
         guPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LWs7AqRcsJIuTaEyljmzXxNtVa28ecrdNGzJsWNp11U=;
        b=lTB0yM4LBSKlVI1TTsIxLvtvOmHxLloP0QPw0Rbg8TCKNewFMGD0tUk7kWo84H3GQw
         hFO5bCz+KYlbur0rI7dJ28pjd/oW6fLqUf4QRmO4LGrBeFcWf5/KNbVyUP0zJ0mrUGKB
         wjWBHATh0T7Fz66FC0r9aOOXZa5PvaMsHtWZ/KYnPtqE8dYTbqnc980UY80eF2mQOWJe
         gnVGd6tsbUBMADhnN5BzNqEBGFHZSzotXTZ9k4oCLKjpS627XOPptrCwX7mWC/kmEdqv
         oXmZqAxV1hB9kdZF4PQPT0reV1w0VtgXr0SVI/dvi1AcsCaxyzzutXZ7oA8cBZIDQtrS
         KUjw==
X-Gm-Message-State: AJIora/EmbI58O6Y1bqJrfX2+CrlKD5Fgds6ak0iD+ByL3IbbtzMGGG6
        spxtOc3r4Lm6eJXM3CgyDmRfsw==
X-Google-Smtp-Source: AGRyM1vuK+qdbwnYF+t1IkZorHQBD9R9Bz9OTjqWnlUPp9g/klW1r18aFepZ1hRe8YwQ9/r+/TVoGw==
X-Received: by 2002:a05:6512:228d:b0:489:c925:e045 with SMTP id f13-20020a056512228d00b00489c925e045mr7535080lfu.545.1657877637867;
        Fri, 15 Jul 2022 02:33:57 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id k1-20020a2eb741000000b0025d542731ffsm682135ljo.5.2022.07.15.02.33.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jul 2022 02:33:56 -0700 (PDT)
Message-ID: <044a9736-a4ec-c250-7755-c80a5bcbe38b@linaro.org>
Date:   Fri, 15 Jul 2022 11:33:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] dt-bindings: fpga: add binding doc for ecp5-spi fpga
 mgr
Content-Language: en-US
To:     Ivan Bornyakov <i.bornyakov@metrotek.ru>, mdf@kernel.org,
        hao.wu@intel.com, yilun.xu@intel.com, trix@redhat.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, system@metrotek.ru
References: <20220714122657.17972-1-i.bornyakov@metrotek.ru>
 <20220714122657.17972-3-i.bornyakov@metrotek.ru>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220714122657.17972-3-i.bornyakov@metrotek.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 14/07/2022 14:26, Ivan Bornyakov wrote:
> Add Device Tree Binding doc for Lattice ECP5 FPGA manager using slave
> SPI to load .bit formatted uncompressed bitstream image.
> 
> Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>
> ---
>  .../fpga/lattice,ecp5-spi-fpga-mgr.yaml       | 71 +++++++++++++++++++
>  1 file changed, 71 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fpga/lattice,ecp5-spi-fpga-mgr.yaml
> 
> diff --git a/Documentation/devicetree/bindings/fpga/lattice,ecp5-spi-fpga-mgr.yaml b/Documentation/devicetree/bindings/fpga/lattice,ecp5-spi-fpga-mgr.yaml
> new file mode 100644
> index 000000000000..79868f9c84e2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/fpga/lattice,ecp5-spi-fpga-mgr.yaml
> @@ -0,0 +1,71 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/fpga/lattice,ecp5-spi-fpga-mgr.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Lattice ECP5 FPGA manager.
> +
> +maintainers:
> +  - Ivan Bornyakov <i.bornyakov@metrotek.ru>
> +
> +description:
> +  Device Tree Bindings for Lattice ECP5 FPGA Manager using slave SPI to
> +  load the uncompressed bitstream in .bit format.

s/Device Tree Bindings for//

Instead describe the hardware you are adding bindings for. What is a
"Manager"? It is so broad and unspecific... It is some dedicated
hardware to communicate with FPGA or you just called this regular FPGA
interface exposed to the CPU/SoC?

> +
> +properties:
> +  compatible:
> +    enum:
> +      - lattice,ecp5-spi-fpga-mgr

Do not encode interface name in compatible so no "spi".

> +
> +  reg:
> +    description: SPI chip select
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 60000000

Reference spi/spi-peripheral-props.yaml in allOf

> +
> +  program-gpios:
> +    description:
> +      A GPIO line connected to PROGRAMN (active low) pin of the device.
> +      Initiates configuration sequence.
> +    maxItems: 1
> +
> +  init-gpios:
> +    description:
> +      A GPIO line connected to INITN (active low) pin of the device.
> +      Indicates the FPGA is ready to be configured.
> +    maxItems: 1
> +
> +  done-gpios:
> +    description:
> +      A GPIO line connected to DONE (active high) pin of the device.
> +      Indicates that the configuration sequence is complete.
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - program-gpios
> +  - init-gpios
> +  - done-gpios
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    spi {
> +            #address-cells = <1>;

Wrong indentation. 4-spaces for DTS example.

> +            #size-cells = <0>;
> +
> +            fpga_mgr@0 {

No underscores in node names.

> +                    compatible = "lattice,ecp5-spi-fpga-mgr";
> +                    spi-max-frequency = <20000000>;
> +                    reg = <0>;
> +                    program-gpios = <&gpio3 4 GPIO_ACTIVE_LOW>;
> +                    init-gpios = <&gpio3 3 GPIO_ACTIVE_LOW>;
> +                    done-gpios = <&gpio3 2 GPIO_ACTIVE_HIGH>;
> +            };
> +    };


Best regards,
Krzysztof
