Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B218C6A1DDA
	for <lists+linux-fpga@lfdr.de>; Fri, 24 Feb 2023 15:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjBXOzN (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 24 Feb 2023 09:55:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjBXOzM (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 24 Feb 2023 09:55:12 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4816451908
        for <linux-fpga@vger.kernel.org>; Fri, 24 Feb 2023 06:55:11 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id p18-20020a05600c359200b003dc57ea0dfeso2409535wmq.0
        for <linux-fpga@vger.kernel.org>; Fri, 24 Feb 2023 06:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aMQW/ellgn1pXltseM1o0F3wQ2R9xKG925J3WLYtIok=;
        b=da+dhW3QJGErTX3NvZ44iKfDDxZfxs7rL/V3IoMNmgzNYJwx1qOUL6cUAwuIgk5h++
         Zlm+8xoPSooEP9p/PH2bGZC4t8msBI59TyTkvw+FMvwfJAAOlTx41H3JCAK9/VEa0fyR
         MNGf7H7EVCQJcbGdck0Oab8BEStnje4WV42ExHLsQNJioAcsY2dX5oYYsiLCmbWHfZNj
         rOLv9VFyHtIJEoHh2PT8QlzSbGtFz8otcXVj3bXcrX/zG2Us0Mua57SYyn5OQmUZpLN9
         Mx9oYaa8at9pNGp7P7WxD5/ebwN9o3l0G6N6qa6A3Ef/UQBtUbUMdbMr81bzFzgTNMSB
         aQZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aMQW/ellgn1pXltseM1o0F3wQ2R9xKG925J3WLYtIok=;
        b=ngjjS/Gd5MZqsK78u7xqh+P+TBFuNg6rbEpul/SIwlKbGFU1al9RAe75zcAGqdeJTA
         DqfnAftULrbs6HsxweqMj6Z3Z7zQF0ZlpFvFA4MBxG1FFz+tXIUfacYnfJ1GVz+KxsM4
         EF2SjGM3xis59B8B4Rea5Y11o3D4tnNilQmIp/LZUs17tRnq2SFc3/jXU3/0FBzWVDP3
         W5LzWelAj3Z3fmiSPRH7DeBhVGbWlhI6U3x6ZgMaJkrJb53ITJxB07a/Vv96QlWLHWbo
         HbHB74Mq2FyrskZlRzrR83ILCLBk04EOVQaaMfuMyJq+biE44kiAqP3aTioDrqLRqHp3
         9OWA==
X-Gm-Message-State: AO0yUKVQvR/cAZaM6v26DXdX9AuDqf+HAWqYuElsXVDLTlt4spGUp5qf
        R1nbx66fm1Ded9XpFYS/z1Gv1g==
X-Google-Smtp-Source: AK7set9n3yDeszAz6rxtpcHWPJpCYXtZPQyoC7QSt/RBAGQZWNXLHu3H4DAGoH3J6E1tycXa0VMDTQ==
X-Received: by 2002:a05:600c:4d18:b0:3ea:e554:7808 with SMTP id u24-20020a05600c4d1800b003eae5547808mr3256028wmp.19.1677250509708;
        Fri, 24 Feb 2023 06:55:09 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id q9-20020a1ce909000000b003dff870ce0esm3104352wmc.2.2023.02.24.06.55.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Feb 2023 06:55:09 -0800 (PST)
Message-ID: <2df19bef-5565-6961-3235-bf1ea21eabfe@linaro.org>
Date:   Fri, 24 Feb 2023 15:55:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] dt-bindings: fpga: xilinx-spi: convert bindings to
 json-schema
Content-Language: en-US
To:     Nava kishore Manne <nava.kishore.manne@amd.com>, mdf@kernel.org,
        hao.wu@intel.com, yilun.xu@intel.com, trix@redhat.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        michal.simek@xilinx.com, linux-fpga@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230224113711.193903-1-nava.kishore.manne@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230224113711.193903-1-nava.kishore.manne@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 24/02/2023 12:37, Nava kishore Manne wrote:
> Convert xilinx-spi bindings to DT schema format using json-schema

Missing full stop.

> 
> Signed-off-by: Nava kishore Manne <nava.kishore.manne@amd.com>
> ---
>  .../bindings/fpga/xilinx-slave-serial.txt     | 51 ------------
>  .../bindings/fpga/xlnx,fpga-slave-serial.yaml | 77 +++++++++++++++++++
>  2 files changed, 77 insertions(+), 51 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/fpga/xilinx-slave-serial.txt
>  create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,fpga-slave-serial.yaml


Thank you for your patch. There is something to discuss/improve.


> +++ b/Documentation/devicetree/bindings/fpga/xlnx,fpga-slave-serial.yaml
> @@ -0,0 +1,77 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/fpga/xlnx,fpga-slave-serial.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Xilinx Slave Serial SPI FPGA driver.

Drop driver and full stop.

> +
> +maintainers:
> +  - Nava kishore Manne <nava.kishore.manne@amd.com>
> +
> +description: |
> +  Xilinx Spartan-6 and 7 Series FPGAs support a method of loading the bitstream
> +  over what is referred to as slave serial interface.The slave serial link is
> +  not technically SPI, and might require extra circuits in order to play nicely
> +  with other SPI slaves on the same bus.
> +  Please refer to fpga-region.txt in this directory for  common binding part
> +  and usage.

Just one space, not two. But what exactly from fpga-region comes here?
If it is used, you need to mention it otherwise it's not allowed to be
used...


> +
> +  Datasheets:
> +    https://www.xilinx.com/support/documentation/user_guides/ug380.pdf
> +    https://www.xilinx.com/support/documentation/user_guides/ug470_7Series_Config.pdf
> +    https://www.xilinx.com/support/documentation/application_notes/xapp583-fpga-configuration.pdf
> +

Missing allOf to spi-peripheral-props.

> +properties:
> +  compatible:
> +    items:

No need for items, drop it.

> +      - enum:
> +          - xlnx,fpga-slave-serial
> +
> +  spi-cpha: true
> +
> +  spi-max-frequency:
> +    maximum: 60000000
> +
> +  reg:
> +    maxItems: 1
> +
> +  prog_b-gpios:
> +    description:
> +      config pin (referred to as PROGRAM_B in the manual)

maxItems

> +
> +  done-gpios:
> +    description:
> +      config status pin (referred to as DONE in the manual)

maxItems

> +
> +  init-b-gpios:
> +    description:
> +      initialization status and configuration error pin
> +      (referred to as INIT_B in the manual)

maxItems

> +
> +required:
> +  - compatible
> +  - reg
> +  - prog_b-gpios
> +  - done-gpios
> +  - init-b-gpios
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    spi0 {

spi

> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      fpga_mgr_spi: fpga-mgr@0 {
> +        compatible = "xlnx,fpga-slave-serial";
> +        spi-max-frequency = <60000000>;
> +        spi-cpha;
> +        reg = <0>;
> +        prog_b-gpios = <&gpio0 29 GPIO_ACTIVE_LOW>;
> +        init-b-gpios = <&gpio0 28 GPIO_ACTIVE_LOW>;
> +        done-gpios = <&gpio0 9 GPIO_ACTIVE_HIGH>;
> +      };
> +    };
> +...

Best regards,
Krzysztof

