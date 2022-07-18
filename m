Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8A35785AD
	for <lists+linux-fpga@lfdr.de>; Mon, 18 Jul 2022 16:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233357AbiGROlI (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 18 Jul 2022 10:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233184AbiGROlI (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 18 Jul 2022 10:41:08 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3920C2409E
        for <linux-fpga@vger.kernel.org>; Mon, 18 Jul 2022 07:41:06 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id x10so13391946ljj.11
        for <linux-fpga@vger.kernel.org>; Mon, 18 Jul 2022 07:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Ci7F28h0QQ63J1UQ0IbGVCP5IPYL4avW86TgMkE39Gk=;
        b=fmo9khIGvEsz1xiJMAOAc6/I4R3184pwNUfqF4IQOzSoXDBIFfC5x3Nh5sJwReXl8E
         XGayaqovL+ypaCGwxpdA0B0lTRpGH/wTBzffS3pKF2hDoQLipwSbh0BPJHBstm2eOQUl
         XnmCYO19Sn/tvtc9n0UQOCMw7QkVUqTvhizNmyT5cqgd8i+KK6EkqM0cBfzyiCklv1hU
         69JvAUK4TG2WYrkfdE+VxRLrtYprwE6/RZLBML4B+N9zPDVXG18nKf4q+Tgjc68EZwV2
         KXZ8pCSdtCm+wbR8MkRMxGAgE15egxje8GfjazSSDq9yKTiXAnqu9UHDLMwPMQv/qv/h
         K1wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ci7F28h0QQ63J1UQ0IbGVCP5IPYL4avW86TgMkE39Gk=;
        b=w1ZjfrZB6seL734DJ2s4+Nqed9IXUy1oJFIjEVS/0tPhLth9UjNBE8GBn7G3ES3s8d
         kO1ybc9FZD/ADPu/IUKCjz48YSdre20kduWcGRcptbz4A6X4FiaFcMcOsSXfKdilu65T
         lFo1TGWjKv5lLJkDazYS+r+b8gFe7Skbujx0Zf4127DXKdJijQ+BashinRs0krGr1IXB
         tMOn5u926fT2uFL6g9dCC4DvS+nGjCcMXCaEtbNRhNaEkd2P2JtwZn7zx2hM9JQCHWks
         pmAH2Yn7wY8lkFklM9skMdLjfy1vJQHtVN80pU2B0REdx45H1D5XC709XuoGu61XIfbo
         a1Xg==
X-Gm-Message-State: AJIora/JHRdGBr7X+ZA4yQ6EOi/Q70+68MQMm/rJyi/6vTPN2JSQSf/U
        QkI9A8pWnQw+1uBvZzYDIT6Khg==
X-Google-Smtp-Source: AGRyM1sJgxFTOigxI3NWFZOi/jL77UmINYpCQfEV0MQZAu1cfk29Kbxp7i/ydRkfwRsKYoSdD+Ql8g==
X-Received: by 2002:a2e:9ed1:0:b0:25d:527e:28e4 with SMTP id h17-20020a2e9ed1000000b0025d527e28e4mr13627677ljk.478.1658155264551;
        Mon, 18 Jul 2022 07:41:04 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id y10-20020a0565123f0a00b0047f7464f1bbsm2628434lfa.116.2022.07.18.07.41.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 07:41:03 -0700 (PDT)
Message-ID: <13095aee-2776-8afe-7bf5-fd8f163c6b2a@linaro.org>
Date:   Mon, 18 Jul 2022 16:41:02 +0200
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
 <2a96f734-010d-b42d-8418-715d7c420272@linaro.org>
 <20220718134654.w2b4vmixjijhvqta@h-e2.ddg>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220718134654.w2b4vmixjijhvqta@h-e2.ddg>
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

On 18/07/2022 15:46, Ivan Bornyakov wrote:
> On Mon, Jul 18, 2022 at 03:06:18PM +0200, Krzysztof Kozlowski wrote:
>> On 15/07/2022 12:03, Ivan Bornyakov wrote:
>>> On Fri, Jul 15, 2022 at 11:33:54AM +0200, Krzysztof Kozlowski wrote:
>>>> On 14/07/2022 14:26, Ivan Bornyakov wrote:
>>>>> Add Device Tree Binding doc for Lattice ECP5 FPGA manager using slave
>>>>> SPI to load .bit formatted uncompressed bitstream image.
>>>>>
>>>>> Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>
>>>>> ---
>>>>>  .../fpga/lattice,ecp5-spi-fpga-mgr.yaml       | 71 +++++++++++++++++++
>>>>>  1 file changed, 71 insertions(+)
>>>>>  create mode 100644 Documentation/devicetree/bindings/fpga/lattice,ecp5-spi-fpga-mgr.yaml
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/fpga/lattice,ecp5-spi-fpga-mgr.yaml b/Documentation/devicetree/bindings/fpga/lattice,ecp5-spi-fpga-mgr.yaml
>>>>> new file mode 100644
>>>>> index 000000000000..79868f9c84e2
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/fpga/lattice,ecp5-spi-fpga-mgr.yaml
>>>>> @@ -0,0 +1,71 @@
>>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>>> +%YAML 1.2
>>>>> +---
>>>>> +$id: http://devicetree.org/schemas/fpga/lattice,ecp5-spi-fpga-mgr.yaml#
>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>> +
>>>>> +title: Lattice ECP5 FPGA manager.
>>>>> +
>>>>> +maintainers:
>>>>> +  - Ivan Bornyakov <i.bornyakov@metrotek.ru>
>>>>> +
>>>>> +description:
>>>>> +  Device Tree Bindings for Lattice ECP5 FPGA Manager using slave SPI to
>>>>> +  load the uncompressed bitstream in .bit format.
>>>>
>>>> s/Device Tree Bindings for//
>>>>
>>>> Instead describe the hardware you are adding bindings for. What is a
>>>> "Manager"? It is so broad and unspecific... It is some dedicated
>>>> hardware to communicate with FPGA or you just called this regular FPGA
>>>> interface exposed to the CPU/SoC?
>>>>
>>>
>>> "FPGA Manager" is a kernel subsystem that exports a set of functions for
>>> programming an FPGA with a bitstream image.
>>> See Documentation/driver-api/fpga/fpga-mgr.rst
>>
>> This is what you want to include in the bindings document? How is it
>> related to bindings? We do not talk about driver API but we talk about
>> hardware. Bindings are for the hardware.
>>
> 
> I've send out v3 not too long ago. If you found the wording there not
> good enough, could you look through
> Documentation/devicetree/bindings/fpga/ and point me to a proper example?
> 
>>>
>>>>> +
>>>>> +properties:
>>>>> +  compatible:
>>>>> +    enum:
>>>>> +      - lattice,ecp5-spi-fpga-mgr
>>>>
>>>> Do not encode interface name in compatible so no "spi".
>>>>
>>>
>>> Recently when I submitted FPGA manager for Microchip PolarFire, I was
>>> asked the opposite, to add "spi" in compatible. The reason was that FPGA
>>> can be programmed through other interfaces as well.
>>
>> I don't see such comment from Rob (DT maintainer):
>> https://lore.kernel.org/all/?q=%22dt-bindings%3A+fpga%3A+add+binding+doc+for+microchip-spi+fpga+mgr%22
>>
>> Can you point me to it?
>>
> 
> Yeah, it was not Rob but other developer:
> https://lore.kernel.org/all/79328410-e56f-7c8a-9d17-de9bfdb98f51@microchip.com/
> 

The type of bus should not be included in the compatible. It's obvious
by looking at the parent, so Conor's comment was not helpful, IMO.

> And at that point I had not even written the bindings doc, so neither
> you nor Rob weren't in the Cc.
> 
> But eventually Rob reviewed DT bindings doc for PolarFire with
> compatible string to be "microchip,mpf-spi-fpga-mgr"
> https://lore.kernel.org/all/YkORrgC1FdzaKCMW@robh.at.kernel.org/
> 
> So I thought it was OK.

If spi was at the end, probably would be easier to spot thus would
trigger a comment.


Best regards,
Krzysztof
