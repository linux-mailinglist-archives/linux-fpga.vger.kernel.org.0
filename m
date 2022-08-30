Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E96D35A6C17
	for <lists+linux-fpga@lfdr.de>; Tue, 30 Aug 2022 20:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiH3SZz (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 30 Aug 2022 14:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbiH3SZn (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 30 Aug 2022 14:25:43 -0400
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D38ADEE4;
        Tue, 30 Aug 2022 11:25:42 -0700 (PDT)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-11ba6e79dd1so18714034fac.12;
        Tue, 30 Aug 2022 11:25:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=rJF6FPuXk90xNKy2lI+ujwUtcQT5l1Vprj6x03j+OIc=;
        b=qeQFP9C4cssjDmNbE9GKRbC3X7gZH1Ktj0JaUSRPHaNjqPHq8Kyie32c/qqTJh3PZR
         hFo15UA2upcsDD9KTSLyNBFDmb2Z5DLh8GyetKs6fd5wQxnhn3X2HYx2FN1H3WFe0sMJ
         eE4/W/Bc7zzyVRPEiNnjZscVZv7YVJ3Bs/JFDd/o/mKRrJc8QyuYlAvkmfToO7nbiUuh
         GhZTjh5QGZgSEXrhTjCiEefWajWgzFz/r77mAC1yIPOxvnvPLkWPAH7wk6axuEaJFlL6
         QwV8vaRANqUvVSMvt7Bh2fHJL71NCLlI99x9kFyr+crY38y6QJmucIbPxZzpM551RAuA
         9kKg==
X-Gm-Message-State: ACgBeo2yxoifJwRjnZcV7vhrqfVNW9gFUnjj/wkDA71YfUJDKDz6GRFj
        Hj1gkTqfaaV6kgzppDB/4VKsBCOefw==
X-Google-Smtp-Source: AA6agR6ygJdX/TKP+OEp3znfX1qDsOC2jEjLqIQVe68VQRMegXFFesfpgf4wZSriCW1FgRxZP1rfUA==
X-Received: by 2002:a05:6808:2d9:b0:343:3143:8727 with SMTP id a25-20020a05680802d900b0034331438727mr9876862oid.114.1661883941572;
        Tue, 30 Aug 2022 11:25:41 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l9-20020a4ae389000000b0044b47bb023fsm7023099oov.37.2022.08.30.11.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 11:25:41 -0700 (PDT)
Received: (nullmailer pid 1806693 invoked by uid 1000);
        Tue, 30 Aug 2022 18:25:40 -0000
Date:   Tue, 30 Aug 2022 13:25:40 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nava kishore Manne <nava.kishore.manne@amd.com>
Cc:     git@amd.com, krzysztof.kozlowski+dt@linaro.org,
        michal.simek@xilinx.com, mdf@kernel.org, hao.wu@intel.com,
        yilun.xu@intel.com, trix@redhat.com, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, ronak.jain@xilinx.com,
        rajan.vaja@xilinx.com, abhyuday.godhasara@xilinx.com,
        piyush.mehta@xilinx.com, lakshmi.sai.krishna.potthuri@xilinx.com,
        harsha.harsha@xilinx.com, linus.walleij@linaro.org,
        nava.manne@xilinx.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: Re: [PATCH 2/4] bindings: fpga: Add binding doc for the zynqmp afi
 config driver
Message-ID: <20220830182540.GA1797396-robh@kernel.org>
References: <20220824035542.706433-1-nava.kishore.manne@amd.com>
 <20220824035542.706433-3-nava.kishore.manne@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220824035542.706433-3-nava.kishore.manne@amd.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Aug 24, 2022 at 09:25:40AM +0530, Nava kishore Manne wrote:
> Xilinx Zynq US+ MPSoC platform connect the PS to the programmable
> logic(PL) through the AXI port. This AXI port helps to establish
> the data path between the PS and PL. In-order to establish the proper
> communication data path between PS and PL the AXI port data path should
> be configured with the proper Bus-width values.
> 
> This patch adds the binding document for the zynqmp afi config driver
> to handle the AXI port bus-width configurations and PS-PL resets.
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
> +      - enum:
> +          - xlnx,zynqmp-afi-fpga
> +
> +  resets:
> +    description:
> +      A list of phandles for resets listed in reset-names.
> +
> +  reset-names:
> +    items:
> +      - const: pl0-rst
> +      - const: pl1-rst
> +      - const: pl2-rst
> +      - const: pl3-rst

Not all that useful of names given it is just indices. Minimally, '-rst' 
is redundant and I don't know what 'pl' means.

> +
> +patternProperties:
> +  "^xlnx,afifm[0-6]-rd-bus-width$":
> +    description: bus width used to configure the afifm-rd interface.

...width in bits...

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [ 32, 64, 128 ]
> +
> +  "^xlnx,afifm[0-6]-wr-bus-width$":

Can combine these 2:

"^xlnx,afifm[0-6]-(wr|rd)-bus-width$"

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
> +      compatible = "xlnx,zynqmp-afi-fpga";
> +      xlnx,afifm0-rd-bus-width = <32>;
> +      xlnx,afifm1-rd-bus-width = <32>;
> +      xlnx,afifm2-rd-bus-width = <64>;
> +      xlnx,afifm3-rd-bus-width = <128>;
> +      xlnx,afifm4-rd-bus-width = <32>;
> +      xlnx,afifm5-rd-bus-width = <64>;
> +      xlnx,afifm6-rd-bus-width = <128>;
> +      xlnx,afifm0-wr-bus-width = <32>;
> +      xlnx,afifm1-wr-bus-width = <32>;
> +      xlnx,afifm2-wr-bus-width = <64>;
> +      xlnx,afifm3-wr-bus-width = <128>;
> +      xlnx,afifm4-wr-bus-width = <32>;
> +      xlnx,afifm5-wr-bus-width = <64>;
> +      xlnx,afifm6-wr-bus-width = <128>;
> +      xlnx,afifs-ss0-bus-width = <64>;
> +      xlnx,afifs-ss1-bus-width = <64>;
> +      xlnx,afifs-ss2-bus-width = <64>;
> +      resets = <&zynqmp_reset ZYNQMP_RESET_PS_PL0>,
> +               <&zynqmp_reset ZYNQMP_RESET_PS_PL1>,
> +               <&zynqmp_reset ZYNQMP_RESET_PS_PL2>,
> +               <&zynqmp_reset ZYNQMP_RESET_PS_PL3>;
> +      reset-names = "pl0-rst", "pl1-rst", "pl2-rst", "pl3-rst";

Should devices on this bus be child devices or do they fit on some other 
bus?

> +    };
> +
> +...
> -- 
> 2.25.1
> 
> 
