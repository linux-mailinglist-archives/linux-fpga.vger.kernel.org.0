Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8B469F155
	for <lists+linux-fpga@lfdr.de>; Wed, 22 Feb 2023 10:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjBVJYZ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 22 Feb 2023 04:24:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbjBVJYY (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 22 Feb 2023 04:24:24 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B9E24120
        for <linux-fpga@vger.kernel.org>; Wed, 22 Feb 2023 01:24:13 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id k14-20020a05600c1c8e00b003e22107b7ccso842006wms.0
        for <linux-fpga@vger.kernel.org>; Wed, 22 Feb 2023 01:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sTaaRe/E/+knc/ZOJd8lQkzuYDsta684+WarNPI7Vrs=;
        b=tk718+tUffNlmJA0hYjuR0RbAd9tJ/gmKYFf5y0xhF6qxgnHnsYrblsIDdLOctdan+
         N4nWveueUkEOzX3d7nvUd30EsbWzg99D3D8LjwO5E0WB3MJ+8Lnej84Rhz+V6qqRWVHO
         frlVGBvCvuivRQwXZtFwe8ao0XQVMvdxC1qdjnS9raLLNZ6laIXX/bEw8+uQeEDu3Omh
         fGyggUtmJWQzQcMWOCQaOcsm2VbUU+DLrFLqamjFhDsO3TN9h74CeOIu0ZOtYYCk2K3H
         Q3Qjg4O7Ypound17GjbMFzozim3JiVurs6nzRSvaT3ORjc6N7fFighZi9lApoWJniBD4
         ITmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sTaaRe/E/+knc/ZOJd8lQkzuYDsta684+WarNPI7Vrs=;
        b=4pz5bU/i8ezfNT/H6g/IBqFiPvPMPuPx3j44onlB8JwLqpOeCiHasdYRlCJMNwpJbj
         uNI3fFU/F7bH1dLMPbqQK7dJiRxi72PziwJjY/9k5N89t9otuy7L7V+oM0UztQLVWryx
         dUDl3WUDaY7jzNFnCZ9Hjh1p73MKuZxDV4Xs+NatKNq3vbP0icpawoOQHrEX5DIfmFkE
         xeKgzP/HBvqBHOwWVueraXvUYUPWoEECzjh4bbFmJ4iLqnzSWJdr8xc6DfFHP/2JK5M2
         ctIyOMRRUDi+Fs7xgL/HuXUQ6ipnMZ3+lAvV5nlVNWiOfZKb8VDfD++0iUEeGjlM0Tn6
         rZpA==
X-Gm-Message-State: AO0yUKULVEGzBMXslDXevqeO6qJUqVEQpV25y2w9ahoIcGPav9k2T01t
        3iNn13gZwM/hErFShH4QOnX7Bg==
X-Google-Smtp-Source: AK7set/e6MoaKe5anwN9nUyHZ3KwQMSrSgfz4cJRifcgmweVwSqwvoChZcu/UyVV+zWrcDok+BN9tw==
X-Received: by 2002:a05:600c:907:b0:3e2:636:24ac with SMTP id m7-20020a05600c090700b003e2063624acmr4898836wmp.14.1677057846858;
        Wed, 22 Feb 2023 01:24:06 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id bd9-20020a05600c1f0900b003e1202744f2sm15978800wmb.31.2023.02.22.01.24.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 01:24:06 -0800 (PST)
Message-ID: <4ce186aa-2cf3-a36c-a5c5-923029b12a29@linaro.org>
Date:   Wed, 22 Feb 2023 10:24:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] dt-bindings: fpga: xilinx-pr-decoupler: convert
 bindings to json-schema
Content-Language: en-US
To:     Nava kishore Manne <nava.kishore.manne@amd.com>, mdf@kernel.org,
        hao.wu@intel.com, yilun.xu@intel.com, trix@redhat.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        michal.simek@xilinx.com, linux-fpga@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230221115012.3468798-1-nava.kishore.manne@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230221115012.3468798-1-nava.kishore.manne@amd.com>
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

On 21/02/2023 12:50, Nava kishore Manne wrote:
> Convert xilinx-pr-decoupler bindings to DT schema format using json-schema
> 
> Signed-off-by: Nava kishore Manne <nava.kishore.manne@amd.com>
> ---
> Changes for v2:
>               - Updated the description and addressed some minor comments
>                 as suggested by Krzysztof.
> 
>  .../bindings/fpga/xilinx-pr-decoupler.txt     | 54 --------------
>  .../bindings/fpga/xlnx,pr-decoupler.yaml      | 71 +++++++++++++++++++
>  2 files changed, 71 insertions(+), 54 deletions(-)
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
> index 000000000000..4a08d4bfa20d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/fpga/xlnx,pr-decoupler.yaml
> @@ -0,0 +1,71 @@
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
> +description: The Xilinx LogiCORE Partial Reconfig Decoupler manages one or more

Blank line before text... don't use your own style. Use style consistent
with the project.

> +  decouplers / fpga bridges. The controller can decouple/disable the bridges
> +  which prevents signal changes from passing through the bridge.  The controller
> +  can also couple / enable the bridges which allows traffic to pass through the
> +  bridge normally.
> +  Xilinx LogiCORE Dynamic Function eXchange(DFX) AXI shutdown manager Softcore
> +  is compatible with the Xilinx LogiCORE pr-decoupler. The Dynamic Function
> +  eXchange AXI shutdown manager prevents AXI traffic from passing through the
> +  bridge. The controller safely handles AXI4MM and AXI4-Lite interfaces on a
> +  Reconfigurable Partition when it is undergoing dynamic reconfiguration,
> +  preventing the system deadlock that can occur if AXI transactions are
> +  interrupted by DFX.
> +  Please refer to fpga-region.txt and fpga-bridge.txt in this directory for
> +  common binding part and usage.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - const: xlnx,pr-decoupler-1.00 #For PR-Decoupler.

Drop the comment, it duplicates the compatible. There is no point in it.

> +          - const: xlnx,pr-decoupler
> +      - items:
> +          - const: xlnx,dfx-axi-shutdown-manager-1.00 #For AXI shutdown manager.

Ditto

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
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1]
> +    description:
> +      Zero if driver should disable bridge at startup. One if driver should
> +      enable bridge at startup. Default is to leave bridge in current state.

This property wasn't in original binding. Even though it is
fpga-bridge.txt, why do you need it? It's not used. Also, do not
describe driver but rather hardware.


Best regards,
Krzysztof

