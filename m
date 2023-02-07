Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D477A68D4F8
	for <lists+linux-fpga@lfdr.de>; Tue,  7 Feb 2023 11:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbjBGK5m (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 7 Feb 2023 05:57:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbjBGK5l (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 7 Feb 2023 05:57:41 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A10842B60D
        for <linux-fpga@vger.kernel.org>; Tue,  7 Feb 2023 02:57:36 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so12874857wma.1
        for <linux-fpga@vger.kernel.org>; Tue, 07 Feb 2023 02:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f8FZcb4uzFMfPmtWP/l5hxVwHej/vJK/aKrsjsyG4Cg=;
        b=hLnwnCcPA8db5bjm0+ND5ByI90aSO4VtqvnJu/6xdGsiQKIjcP50gblOpw7ouQku1A
         UCXeVuwZuSOhrgbddcnt84uECl0KY8mhVpx+bn/o6YZXqpZYzJs5lSPy4PpVPLNxBlLy
         gJJ5ckX4W3AeNOq395lPVzM+dSWhLT23nwrtj35n5XnV/qeWnWygHfiyEqvyezamLWpF
         pNMtI89IIBshO3jRuYEv5r2sJrqza6LTB5fuUc/F0713szrwpOgKti+RKlwy4O158cxC
         77Lm7WRxjirfAlbVr88jsfaky93tDRBaR23UcnniDgVBIVnOcSM5BXivYfoBz4tj3uQS
         M4Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f8FZcb4uzFMfPmtWP/l5hxVwHej/vJK/aKrsjsyG4Cg=;
        b=owH7A3z8dC7c49YDYltFdTzUtHDnu5/ORMPQX3RLXWXpNwztSoBUj0whx+f9y34XD8
         uEX+AnkSov+jJDZ9RKv9TKhI62bstr7BKxPu1vXrTfagYKr9xvohypYmGvgtCDFldtyX
         l28gSLBP9aIF5ZIwXMN7U3NTJq1UG4c8UTlQFWVj3zV4RkW/Bqmdnp9zalkmri6fyVMs
         vsXsxvv6X8pf2ZxP3oruH5guSG9amEx8xBPgYtB2LFFM8+mXOihx9B4xAw3WSFcOvYjq
         H5O9cSMhdofxAwBqXzdhc5DxzhfGC5gX0CfutsfkoYDdhAo9tYrsUMh0iKM7U+sJJYcj
         T0pQ==
X-Gm-Message-State: AO0yUKUurLyMRkXxlc7MGFB8Kymu7RaHMoPJJKgEZvjpr/nScke8Svgm
        pPSPQ7aEtKrcVdD7oRtnDvkNvA==
X-Google-Smtp-Source: AK7set8KJo95kIYX47xfryIGgOz80ooU+wyiOu6FqauMXidnVWF7t7U7A0ekyJ4cp0l6r5KMZslZeQ==
X-Received: by 2002:a05:600c:9a2:b0:3dc:576c:ab07 with SMTP id w34-20020a05600c09a200b003dc576cab07mr2755796wmp.14.1675767455224;
        Tue, 07 Feb 2023 02:57:35 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id m20-20020a05600c3b1400b003db1ca20170sm14832575wms.37.2023.02.07.02.57.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 02:57:34 -0800 (PST)
Message-ID: <ae5ed7e6-1f4f-c45f-06ef-dd5566e8a7d0@linaro.org>
Date:   Tue, 7 Feb 2023 11:57:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] dt-bindings: fpga: convert bindings document to yaml
Content-Language: en-US
To:     Nava kishore Manne <nava.kishore.manne@amd.com>, mdf@kernel.org,
        hao.wu@intel.com, yilun.xu@intel.com, trix@redhat.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        michal.simek@xilinx.com, linux-fpga@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230207104812.182439-1-nava.kishore.manne@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230207104812.182439-1-nava.kishore.manne@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 07/02/2023 11:48, Nava kishore Manne wrote:
> Convert the xilinx-pr-decoupler binding document from txt to yaml.
> 
> Signed-off-by: Nava kishore Manne <nava.kishore.manne@amd.com>

Use subject prefixes matching the subsystem (which you can get for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching).

missing final component for prefixes

Subject: drop second/last, redundant "bindings document". The
"dt-bindings" prefix is already stating that these are bindings.

> ---
>  .../bindings/fpga/xilinx-pr-decoupler.txt     | 54 -------------
>  .../bindings/fpga/xlnx,pr-decoupler.yaml      | 76 +++++++++++++++++++
>  2 files changed, 76 insertions(+), 54 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/fpga/xilinx-pr-decoupler.txt
>  create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,pr-decoupler.yaml
> 
> diff --git a/Documentation/devicetree/bindings/fpga/xilinx-pr-decoupler.txt b/Documentation/devicetree/bindings/fpga/xilinx-pr-decoupler.txt
> deleted file mode 100644
> index 0acdfa6d62a4..000000000000
> --- a/Documentation/devicetree/bindings/fpga/xilinx-pr-decoupler.txt
> +++ /dev/null
> @@ -1,54 +0,0 @@
> -Xilinx LogiCORE Partial Reconfig Decoupler Softcore
> -
> -The Xilinx LogiCORE Partial Reconfig Decoupler manages one or more
> -decouplers / fpga bridges.
> -The controller can decouple/disable the bridges which prevents signal
> -changes from passing through the bridge.  The controller can also
> -couple / enable the bridges which allows traffic to pass through the
> -bridge normally.
> -
> -Xilinx LogiCORE Dynamic Function eXchange(DFX) AXI shutdown manager
> -Softcore is compatible with the Xilinx LogiCORE pr-decoupler.
> -
> -The Dynamic Function eXchange AXI shutdown manager prevents AXI traffic
> -from passing through the bridge. The controller safely handles AXI4MM
> -and AXI4-Lite interfaces on a Reconfigurable Partition when it is
> -undergoing dynamic reconfiguration, preventing the system deadlock
> -that can occur if AXI transactions are interrupted by DFX
> -
> -The Driver supports only MMIO handling. A PR region can have multiple
> -PR Decouplers which can be handled independently or chained via decouple/
> -decouple_status signals.
> -
> -Required properties:
> -- compatible		: Should contain "xlnx,pr-decoupler-1.00" followed by
> -                          "xlnx,pr-decoupler" or
> -                          "xlnx,dfx-axi-shutdown-manager-1.00" followed by
> -                          "xlnx,dfx-axi-shutdown-manager"
> -- regs			: base address and size for decoupler module
> -- clocks		: input clock to IP
> -- clock-names		: should contain "aclk"
> -
> -See Documentation/devicetree/bindings/fpga/fpga-region.txt and
> -Documentation/devicetree/bindings/fpga/fpga-bridge.txt for generic bindings.
> -
> -Example:
> -Partial Reconfig Decoupler:
> -	fpga-bridge@100000450 {
> -		compatible = "xlnx,pr-decoupler-1.00",
> -			     "xlnx-pr-decoupler";
> -		regs = <0x10000045 0x10>;
> -		clocks = <&clkc 15>;
> -		clock-names = "aclk";
> -		bridge-enable = <0>;
> -	};
> -
> -Dynamic Function eXchange AXI shutdown manager:
> -	fpga-bridge@100000450 {
> -		compatible = "xlnx,dfx-axi-shutdown-manager-1.00",
> -			     "xlnx,dfx-axi-shutdown-manager";
> -		regs = <0x10000045 0x10>;
> -		clocks = <&clkc 15>;
> -		clock-names = "aclk";
> -		bridge-enable = <0>;
> -	};
> diff --git a/Documentation/devicetree/bindings/fpga/xlnx,pr-decoupler.yaml b/Documentation/devicetree/bindings/fpga/xlnx,pr-decoupler.yaml
> new file mode 100644
> index 000000000000..caea58a9ba7d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/fpga/xlnx,pr-decoupler.yaml
> @@ -0,0 +1,76 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/fpga/xlnx,pr-decoupler.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Xilinx LogiCORE Partial Reconfig Decoupler/AXI shutdown manager Softcore
> +
> +maintainers:
> +  - Nava kishore Manne <nava.kishore.manne@amd.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - description: The Xilinx LogiCORE Partial Reconfig Decoupler manages one
> +          or more decouplers / fpga bridges. The controller can decouple/disable
> +          the bridges which prevents signal changes from passing through the
> +          bridge. The controller can also couple / enable the bridges which
> +          allows traffic to pass through the bridge normally.

Description of device goes to toplevel "description" field. Not here.
Here you can point shortly differences, but such statement suggests you
should have different bindings.

> +        items:
> +          - const: xlnx,pr-decoupler-1.00
> +          - const: xlnx,pr-decoupler
> +      - description: The Xilinx LogiCORE Dynamic Function eXchange(DFX)
> +          AXI shutdown manager softcore is compatible with the Xilinx
> +          LogiCORE pr-decoupler. The Dynamic Function eXchange AXI shutdown
> +          manager prevents AXI traffic from passing through the bridge.
> +          The controller safely handles AXI4MM and AXI4-Lite interfaces on
> +          a Reconfigurable Partition when it is undergoing dynamic
> +          reconfiguration, preventing the system deadlock that can occur
> +          if AXI transactions are interrupted by DFX.

Same problem.

> +        items:
> +          - const: xlnx,dfx-axi-shutdown-manager-1.00
> +          - const: xlnx,dfx-axi-shutdown-manager
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: aclk
> +
> +  bridge-enable:

Missing type/ref.

> +    description:
> +      Zero if driver should disable bridge at startup

Are these sentences? Then missing full sotp.


> +      One if driver should enable bridge at startup
> +      Default is to leave bridge in current state.

Missing enum.

> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +
> +unevaluatedProperties: false

Instead (you do not reference any other binding):
additionalProperties: false

Anyway, I have doubts it you tested it. Just read fpga-region bindings
and original TXT... It clearly points to regions. Where are they?

> +
> +examples:
> +  - |
> +    fpga-bridge@100000450 {
> +      compatible = "xlnx,pr-decoupler-1.00", "xlnx,pr-decoupler";
> +      reg = <0x10000045 0x10>;
> +      clocks = <&clkc 15>;
> +      clock-names = "aclk";
> +      bridge-enable = <0>;
> +    };
> +
> +  - |
> +    fpga-bridge@100000850 {

Drop second example, it's basically the same.

> +      compatible = "xlnx,dfx-axi-shutdown-manager-1.00", "xlnx,dfx-axi-shutdown-manager";
> +      reg = <0x10000045 0x10>;
> +      clocks = <&clkc 15>;
> +      clock-names = "aclk";
> +      bridge-enable = <0>;
> +    };

Best regards,
Krzysztof

