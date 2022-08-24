Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC1DD59FAC0
	for <lists+linux-fpga@lfdr.de>; Wed, 24 Aug 2022 15:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237839AbiHXM6l (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 24 Aug 2022 08:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237810AbiHXM6j (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 24 Aug 2022 08:58:39 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5358597B33
        for <linux-fpga@vger.kernel.org>; Wed, 24 Aug 2022 05:58:36 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id z20so16373148ljq.3
        for <linux-fpga@vger.kernel.org>; Wed, 24 Aug 2022 05:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=1GfWJHR/x5piPvfICRZ+8DXyaOC916mUwAEahhmR7Bg=;
        b=xBMINWQ/VnjaGVPCE/q0Fg7SvC3mM4CUg/N4QetunqsFUfusnDwjb+M95+dciFHrQu
         RXlojLQTdMp+7djTrK32e70yvN5IzgLipK1UT80IVRp2h7k2At44LN7Pf/hyMTwZuPDb
         77vCF+CW41bFOsBe6RDO2fGdGEsWgScEAQM0D0Sgbsu3aZc8m9eQpKecHe9vFggTmiAt
         yU/KxNpwD+1ufHNstHzvPNZQbh75kXQ2xHT3/I5gs/l3iu4DFaEEbZYIfIvbj3RnEl24
         05LRsymk14UyFyYOrqDGfHgmXs9cfRYI3oNNm4Q/mpZ3rex/mFE2DElbJJ7jpzqdhc8B
         K8ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=1GfWJHR/x5piPvfICRZ+8DXyaOC916mUwAEahhmR7Bg=;
        b=IE9rVdz55ao/JlA97qbKv/MC+lsCC23yBbHmZPVr6uEBwZnDqqq64FvLnFKe2/42K9
         UmgWqEIOnzy8eC07z7lHYuEcNyuJCL0a0GwToNedVxVJyiUtuNHZQ4c6/CxjptzPvQjE
         U58oOYMRbF0gp66/LUy4kOTuzPrKt7zn24oE2+IwrPNfJj6/KDtHoc93bBDaL26qcP+g
         oOTqk0hEybswTRiYdZM3Ua3EpW3URhtDJFQBqprlXl2XMKfgXSjT14NCdDaw8iNDTu+2
         4bv8R8wEt0lvjTGtw4eSdUnqBuVTR1QtUCKp0Xt0e3ZePJ2OzPvHD0bTmamBShE4XUoL
         1Vrg==
X-Gm-Message-State: ACgBeo2CNh3MYR+LjzfWMtQLHel+kGiJY1fPOOrmVJQn3rpUy83KAQRP
        oWjdRoG6OSCN4yDySBevHJixow==
X-Google-Smtp-Source: AA6agR4upOTeoaIh6uzUsa5JU0XIzx+xlCiRe2cq6nttWmYYcb46rp7T/8gMTufYlDHBD4XEHFXbeA==
X-Received: by 2002:a2e:bf07:0:b0:261:cafb:d4a8 with SMTP id c7-20020a2ebf07000000b00261cafbd4a8mr4318756ljr.268.1661345914326;
        Wed, 24 Aug 2022 05:58:34 -0700 (PDT)
Received: from [10.243.4.185] ([194.157.23.230])
        by smtp.gmail.com with ESMTPSA id o14-20020a05651205ce00b0048bd7136ef3sm3012084lfo.221.2022.08.24.05.58.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 05:58:33 -0700 (PDT)
Message-ID: <f7c9c8ee-675b-216c-0e2d-28d11890477a@linaro.org>
Date:   Wed, 24 Aug 2022 15:58:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 2/4] bindings: fpga: Add binding doc for the zynqmp afi
 config driver
Content-Language: en-US
To:     Nava kishore Manne <nava.kishore.manne@amd.com>, git@amd.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        michal.simek@xilinx.com, mdf@kernel.org, hao.wu@intel.com,
        yilun.xu@intel.com, trix@redhat.com, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, ronak.jain@xilinx.com,
        rajan.vaja@xilinx.com, abhyuday.godhasara@xilinx.com,
        piyush.mehta@xilinx.com, lakshmi.sai.krishna.potthuri@xilinx.com,
        harsha.harsha@xilinx.com, linus.walleij@linaro.org,
        nava.manne@xilinx.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
References: <20220824035542.706433-1-nava.kishore.manne@amd.com>
 <20220824035542.706433-3-nava.kishore.manne@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220824035542.706433-3-nava.kishore.manne@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 24/08/2022 06:55, Nava kishore Manne wrote:
> Xilinx Zynq US+ MPSoC platform connect the PS to the programmable
> logic(PL) through the AXI port. This AXI port helps to establish

Use subject prefixes matching the subsystem (git log --oneline -- ...).

> the data path between the PS and PL. In-order to establish the proper
> communication data path between PS and PL the AXI port data path should
> be configured with the proper Bus-width values.
> 
> This patch adds the binding document for the zynqmp afi config driver
> to handle the AXI port bus-width configurations and PS-PL resets.

Do not use "This commit/patch".
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

> 
> Signed-off-by: Nava kishore Manne <nava.kishore.manne@amd.com>
> ---
>  .../bindings/fpga/xlnx,zynqmp-afi-fpga.yaml   | 100 ++++++++++++++++++
>  1 file changed, 100 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,zynqmp-afi-fpga.yaml
> 
> diff --git a/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-afi-fpga.yaml b/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-afi-fpga.yaml
> new file mode 100644
> index 000000000000..faae4951e991
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-afi-fpga.yaml
> @@ -0,0 +1,100 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/fpga/xlnx,zynqmp-afi-fpga.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Xilinx ZynqMP AFI interface Manager.
> +
> +maintainers:
> +  - Nava kishore Manne <nava.kishore.manne@amd.com>
> +
> +description: The Zynq UltraScale+ MPSoC Processing System core provides access
> +  from PL masters to PS internal peripherals, and memory through AXI FIFO
> +  interface(AFI)
> +
> +properties:
> +  compatible:
> +    items:

No items, you have only one item.

> +      - enum:
> +          - xlnx,zynqmp-afi-fpga
> +
> +  resets:
> +    description:
> +      A list of phandles for resets listed in reset-names.

You need maxItems:4

> +
> +  reset-names:
> +    items:
> +      - const: pl0-rst
> +      - const: pl1-rst
> +      - const: pl2-rst
> +      - const: pl3-rst
> +
> +patternProperties:
> +  "^xlnx,afifm[0-6]-rd-bus-width$":
> +    description: bus width used to configure the afifm-rd interface.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [ 32, 64, 128 ]
> +
> +  "^xlnx,afifm[0-6]-wr-bus-width$":
> +    description: bus width used to configure the afifm-wr interface.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [ 32, 64, 128 ]
> +
> +  "^xlnx,afifs-ss[0-2]-bus-width$":
> +    description: bus width used to configure the afifs interface.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [ 32, 64, 128 ]
> +
> +required:
> +  - compatible
> +  - xlnx,afifm0-rd-bus-width
> +  - xlnx,afifm1-rd-bus-width
> +  - xlnx,afifm2-rd-bus-width
> +  - xlnx,afifm3-rd-bus-width
> +  - xlnx,afifm4-rd-bus-width
> +  - xlnx,afifm5-rd-bus-width
> +  - xlnx,afifm6-rd-bus-width
> +  - xlnx,afifm0-wr-bus-width
> +  - xlnx,afifm1-wr-bus-width
> +  - xlnx,afifm2-wr-bus-width
> +  - xlnx,afifm3-wr-bus-width
> +  - xlnx,afifm4-wr-bus-width
> +  - xlnx,afifm5-wr-bus-width
> +  - xlnx,afifm6-wr-bus-width
> +  - xlnx,afifs-ss0-bus-width
> +  - xlnx,afifs-ss1-bus-width
> +  - xlnx,afifs-ss2-bus-width
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/reset/xlnx-zynqmp-resets.h>
> +    zynqmp-afi {

Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation



Best regards,
Krzysztof
