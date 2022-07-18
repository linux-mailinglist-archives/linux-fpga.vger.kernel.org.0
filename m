Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0698F578330
	for <lists+linux-fpga@lfdr.de>; Mon, 18 Jul 2022 15:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235342AbiGRNGd (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 18 Jul 2022 09:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235303AbiGRNG1 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 18 Jul 2022 09:06:27 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7BA3F591
        for <linux-fpga@vger.kernel.org>; Mon, 18 Jul 2022 06:06:21 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id u15so13476539lji.10
        for <linux-fpga@vger.kernel.org>; Mon, 18 Jul 2022 06:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=a+O9vudZmIw0y8HcEu8EeY4zyTPk+O1DAP+t2vVBksA=;
        b=DiSjKH1Qipp92JGNti6EzoCEbaLHb26NceygyY4BOdkstNYl6brT0xu9MlN20tvhTN
         p1SZy0jvCk+w6lZHsdv52GS+OTqS1sj9kxbvT10EdxSvDbHqhzCuRCQQ9P2hnpC1b6LC
         At5s9W/afxoD6Bs83X89slxumpRLIGNaPPay1nO8e3SmDQlWSTZDN2glQcQNa0vSoxRA
         +DJd3FanU4ToJGcr9jGOOqNjYz7uuLjAinYUeSpIJbPNSGMDiVVwYAho+3NGAwQO0dxz
         WNWxagJOEhw+KUMIa7luCCnXcjm5t24lpWyvm3Y/exFntB7aM4syJ52k2gNYJSssB2lP
         yx/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=a+O9vudZmIw0y8HcEu8EeY4zyTPk+O1DAP+t2vVBksA=;
        b=wEv8ss3Z1iJXWsDe818AEIyzB1iOfnFsVLGhPx3obD+7gZBiWPurMbVVItFbHbyfhe
         Kjaf5R4IvsZSNUpmCHCyNbXKndi6SlJedkasVu+aXFxuD7Z8h4IetHAZDWvrxMGgTrRB
         ucl3cNYrLi5vMOP89QRiP1rKSWQCPevMQu+BTGaoMnClIE3vmAdIpajoth1RGLUR54QX
         z7u6MZzVS2X8xNeeLV0F4q6oMMJx3W++NJuMtaNGHYOzUtrldPsNgdrzDSkwtLyJeMF+
         BnBTWN6vGK3b1wFYXKso0ZoKPdZ746qBlFHZNtIkMtT0ZXUjQZSqQTUlibKrZbLB6iC+
         f9xg==
X-Gm-Message-State: AJIora8ehqdiH3vzBrfBYeIGV/z7trurwys7lJtCRU3kxry/Tl4r7KV3
        ivcspi3TIzo1XN/WTqBZmIzytb/5U/s3w7Z9
X-Google-Smtp-Source: AGRyM1vtwkiYg5ErQ9NCTyTYbs/3Slz+OVi7+HIoAuGUzoeHVOGBofEwhslH/MRQOOUsFT2PfU2nlQ==
X-Received: by 2002:a05:651c:23b:b0:25d:6920:2b06 with SMTP id z27-20020a05651c023b00b0025d69202b06mr12121153ljn.226.1658149580235;
        Mon, 18 Jul 2022 06:06:20 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id t8-20020a05651c204800b0025d835fe81esm2082741ljo.115.2022.07.18.06.06.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 06:06:19 -0700 (PDT)
Message-ID: <2a96f734-010d-b42d-8418-715d7c420272@linaro.org>
Date:   Mon, 18 Jul 2022 15:06:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] dt-bindings: fpga: add binding doc for ecp5-spi fpga
 mgr
Content-Language: en-US
To:     Ivan Bornyakov <i.bornyakov@metrotek.ru>
Cc:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        trix@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-fpga@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        system@metrotek.ru
References: <20220714122657.17972-1-i.bornyakov@metrotek.ru>
 <20220714122657.17972-3-i.bornyakov@metrotek.ru>
 <044a9736-a4ec-c250-7755-c80a5bcbe38b@linaro.org>
 <20220715100356.fwjomifweifn6zsr@h-e2.ddg>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220715100356.fwjomifweifn6zsr@h-e2.ddg>
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

On 15/07/2022 12:03, Ivan Bornyakov wrote:
> On Fri, Jul 15, 2022 at 11:33:54AM +0200, Krzysztof Kozlowski wrote:
>> On 14/07/2022 14:26, Ivan Bornyakov wrote:
>>> Add Device Tree Binding doc for Lattice ECP5 FPGA manager using slave
>>> SPI to load .bit formatted uncompressed bitstream image.
>>>
>>> Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>
>>> ---
>>>  .../fpga/lattice,ecp5-spi-fpga-mgr.yaml       | 71 +++++++++++++++++++
>>>  1 file changed, 71 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/fpga/lattice,ecp5-spi-fpga-mgr.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/fpga/lattice,ecp5-spi-fpga-mgr.yaml b/Documentation/devicetree/bindings/fpga/lattice,ecp5-spi-fpga-mgr.yaml
>>> new file mode 100644
>>> index 000000000000..79868f9c84e2
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/fpga/lattice,ecp5-spi-fpga-mgr.yaml
>>> @@ -0,0 +1,71 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/fpga/lattice,ecp5-spi-fpga-mgr.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Lattice ECP5 FPGA manager.
>>> +
>>> +maintainers:
>>> +  - Ivan Bornyakov <i.bornyakov@metrotek.ru>
>>> +
>>> +description:
>>> +  Device Tree Bindings for Lattice ECP5 FPGA Manager using slave SPI to
>>> +  load the uncompressed bitstream in .bit format.
>>
>> s/Device Tree Bindings for//
>>
>> Instead describe the hardware you are adding bindings for. What is a
>> "Manager"? It is so broad and unspecific... It is some dedicated
>> hardware to communicate with FPGA or you just called this regular FPGA
>> interface exposed to the CPU/SoC?
>>
> 
> "FPGA Manager" is a kernel subsystem that exports a set of functions for
> programming an FPGA with a bitstream image.
> See Documentation/driver-api/fpga/fpga-mgr.rst

This is what you want to include in the bindings document? How is it
related to bindings? We do not talk about driver API but we talk about
hardware. Bindings are for the hardware.

> 
>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - lattice,ecp5-spi-fpga-mgr
>>
>> Do not encode interface name in compatible so no "spi".
>>
> 
> Recently when I submitted FPGA manager for Microchip PolarFire, I was
> asked the opposite, to add "spi" in compatible. The reason was that FPGA
> can be programmed through other interfaces as well.

I don't see such comment from Rob (DT maintainer):
https://lore.kernel.org/all/?q=%22dt-bindings%3A+fpga%3A+add+binding+doc+for+microchip-spi+fpga+mgr%22

Can you point me to it?

Best regards,
Krzysztof
