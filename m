Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFB2F5784A3
	for <lists+linux-fpga@lfdr.de>; Mon, 18 Jul 2022 16:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232836AbiGRN62 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 18 Jul 2022 09:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232255AbiGRN61 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 18 Jul 2022 09:58:27 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A9F27FDB
        for <linux-fpga@vger.kernel.org>; Mon, 18 Jul 2022 06:58:25 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id m9so11041072ljp.9
        for <linux-fpga@vger.kernel.org>; Mon, 18 Jul 2022 06:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=scDNluyl3Sc3xGeqgTfNYZogBEUOOlaQnjVhvnH1aKQ=;
        b=LWRdlN3Qf31EcZGv0pnKMXuD8WmWanUevmoH/VV4mhnGAvFytZSZUD+9dTSWms+JkZ
         N+K9p6Khl9Z0OVVT1i0H3sl+uvv/aF2a1r8ATUk5tYG7Q4JtM+okhG2FUUA8DclMfDpm
         SySuuICQU2cM1v4B5wApQIhdzzFgYAYxnm7UxQGJwa+u0GqeIR8Tl3yajLl6iiVq6E3F
         xmMNFceC1nCym4z9xVPxTPBzzyfLBayKrG/MipLIBb25CZWZujsrDRJqxxiht6xfQ6T2
         8qbNWnbnzUtzpxxtbLQGlyADkv01v6HpVbWhbFK8lrSCES4ArJ04dKUW+Oxb8ifmSZh9
         YkWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=scDNluyl3Sc3xGeqgTfNYZogBEUOOlaQnjVhvnH1aKQ=;
        b=RwYKB29m4rtfsXYROJL867L7ZRdamhCEoSgpyXIXvWl+/VbfGpS9q4vmG365ubbiaI
         YiergHiMmlvJ9v7xIp1UAi7OwXJtm24B0+nHav7eLxyl8//gkJIetzX3nfZ6mknMDEWp
         NYYDcdtIa9KxKl7K899TlGf9XxKIpMvfhhAXJbrBOkZ5GGwaz4+BERkl57HA0dezX3sE
         Oq8ms8Q9Kru70mKLNfby5r8iu0nHNrlkHQiGGwxarH1BV5sckMK4ewtEwDuZnO1mfKxL
         cNZImUvza0M7yCVph8Ijil9nI3OQeZbsHnjoXQSl8QqDVRuFCAc+blTfRW4Vl5KWhZdJ
         E2Pw==
X-Gm-Message-State: AJIora+2kWrNrSaE6d7qSBPuB1tQBvCCGs6qgh5JpvhhKMa3Fod1G5Pe
        u76YHRJ5vCgHZ22ZlYPceaS3yQ==
X-Google-Smtp-Source: AGRyM1s7BZkKPvkYka27fRjzNLHeDCKrCHSSUZBaMaOwtazGYvyslxTkViMRRHwXDwYuRAlGKPKJUg==
X-Received: by 2002:a2e:895a:0:b0:25d:6815:98ff with SMTP id b26-20020a2e895a000000b0025d681598ffmr11998753ljk.189.1658152704119;
        Mon, 18 Jul 2022 06:58:24 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id m7-20020a056512114700b0047a0300746fsm2609261lfg.304.2022.07.18.06.58.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 06:58:23 -0700 (PDT)
Message-ID: <d15fcfa1-91ce-70fa-143f-748ead9a4337@linaro.org>
Date:   Mon, 18 Jul 2022 15:58:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 2/2] dt-bindings: fpga: add binding doc for ecp5-spi
 fpga mgr
Content-Language: en-US
To:     Ivan Bornyakov <i.bornyakov@metrotek.ru>, mdf@kernel.org,
        hao.wu@intel.com, yilun.xu@intel.com, trix@redhat.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, system@metrotek.ru
References: <20220718114928.22092-1-i.bornyakov@metrotek.ru>
 <20220718114928.22092-3-i.bornyakov@metrotek.ru>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220718114928.22092-3-i.bornyakov@metrotek.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 18/07/2022 13:49, Ivan Bornyakov wrote:
> Add Device Tree Binding doc for Lattice ECP5 FPGA manager using slave
> SPI to load .bit formatted uncompressed bitstream image.
> 
> Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>
> ---
>  .../bindings/fpga/lattice,ecp5-fpga-mgr.yaml  | 73 +++++++++++++++++++
>  1 file changed, 73 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fpga/lattice,ecp5-fpga-mgr.yaml
> 
> diff --git a/Documentation/devicetree/bindings/fpga/lattice,ecp5-fpga-mgr.yaml b/Documentation/devicetree/bindings/fpga/lattice,ecp5-fpga-mgr.yaml
> new file mode 100644
> index 000000000000..bb10fd316f94
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/fpga/lattice,ecp5-fpga-mgr.yaml
> @@ -0,0 +1,73 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/fpga/lattice,ecp5-fpga-mgr.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Lattice ECP5 Slave SPI FPGA manager.
> +
> +maintainers:
> +  - Ivan Bornyakov <i.bornyakov@metrotek.ru>
> +
> +description:
> +  FPGA Manager capable to program Lattice ECP5 with uncompressed bitstream
> +  image in .bit format over SPI.

The same question as before - you need to explain what is the hardware
(not Linux API or Linux subsystem).

> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml
> +
> +properties:
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 60000000
> +
> +  compatible:
> +    enum:
> +      - lattice,ecp5-fpga-mgr

Compatible goes first in the list of properties. Change here was not
requested, so I am surprised to see different coding style.

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
> +      Indicates that the FPGA is ready to be configured.
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
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        fpga-mgr@0 {
> +            compatible = "lattice,ecp5-fpga-mgr";
> +            spi-max-frequency = <20000000>;
> +            reg = <0>;

compatible then reg, then rest of properties.



Best regards,
Krzysztof
