Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C19D6578588
	for <lists+linux-fpga@lfdr.de>; Mon, 18 Jul 2022 16:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233264AbiGROcx (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 18 Jul 2022 10:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234341AbiGROcu (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 18 Jul 2022 10:32:50 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9B0237DA
        for <linux-fpga@vger.kernel.org>; Mon, 18 Jul 2022 07:32:46 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id w2so13816906ljj.7
        for <linux-fpga@vger.kernel.org>; Mon, 18 Jul 2022 07:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=gEdQYmEqnlsP0uD7xKRiFLeBFu1VzPoHV+TkuJ6H2ao=;
        b=SWoaDom9JBWHsN8wgxDlRqIoDnx/Cb4AlkgNgGU447NI7K2FD/z6tz6CWff3nC8TvY
         f62Ge0qiYdQYJsSr1u+EWUWviRqwk/+scqzDvMwUW4NREU6zEh4AXFfFtHlKdQo7pB8u
         4EeR10DLWiqRYtoNAL670UFOlHoOPmtUQBmQKXKv46isBbvpB44XuDA0H1yfq1gbb7Wu
         PVn1Jk/ygTOps6JdSCfvxH4MlxPWl8YMpqtDvuiHjPcgyApriYxxTc5yHz55+GLNGxrF
         FXmaWfgKlxdKj7dGVetrmpVfSBuQII/47/sQmRanGnQ0OzV4ePXD1z5gA2IcEv/CUgJI
         y7Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gEdQYmEqnlsP0uD7xKRiFLeBFu1VzPoHV+TkuJ6H2ao=;
        b=jo0ZA2GDN+QOh79koQk3N/TjNSSXY+eOICm4CHnfJ5Gw+1A914Ked/+omzlMnQq07E
         mS4LWPNqSc9x8n0Z+HXczpUrgj+TZ30dSQ639kARmn/PMGvyvrKubvouT8MTt+qtPrBQ
         NMi1rv6Kcg+EFDWX2/K4FFi9gWmQBX5aMr8zvmq0E20tBiywRV3tSKchCdOcJLTyocAz
         J2Bu9uIVDyNKMW0AlYB3PVtEHR9AFgp05e8QDRTR64OehsgVVyExbzCDyN4ikqZ1/Dt+
         Tq6fQFvFDHc0swbuUwLPHTS4q0pYWXo5Cg267VqhjALjKkiD7UmcSUWMp09s7jGEl1Hh
         bdOw==
X-Gm-Message-State: AJIora/WF/dSii7kdKjfqBb5sqN7Gyo+eZ8iWFfd6YciD11TjHIsqKhy
        QLACs5xid+RXMk7PX5zvzDO8EA==
X-Google-Smtp-Source: AGRyM1su6+TSqh/bFxly6R5TLik4Rd3lY7VPFNnUzLeF/JOUYG68BNcM2RiaMpvC62B/3SJteUU9zg==
X-Received: by 2002:a2e:b70b:0:b0:25d:52f3:3043 with SMTP id j11-20020a2eb70b000000b0025d52f33043mr12502767ljo.380.1658154764935;
        Mon, 18 Jul 2022 07:32:44 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id x26-20020a19e01a000000b0047f8fd27402sm2634589lfg.146.2022.07.18.07.32.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 07:32:44 -0700 (PDT)
Message-ID: <cca20c06-b53c-b8a2-cd8d-04420c4d1487@linaro.org>
Date:   Mon, 18 Jul 2022 16:32:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 2/2] dt-bindings: fpga: add binding doc for ecp5-spi
 fpga mgr
Content-Language: en-US
To:     Ivan Bornyakov <i.bornyakov@metrotek.ru>
Cc:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        trix@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-fpga@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        system@metrotek.ru
References: <20220718114928.22092-1-i.bornyakov@metrotek.ru>
 <20220718114928.22092-3-i.bornyakov@metrotek.ru>
 <d15fcfa1-91ce-70fa-143f-748ead9a4337@linaro.org>
 <20220718142427.vhwswafw7sa5ec6v@h-e2.ddg>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220718142427.vhwswafw7sa5ec6v@h-e2.ddg>
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

On 18/07/2022 16:24, Ivan Bornyakov wrote:
> On Mon, Jul 18, 2022 at 03:58:22PM +0200, Krzysztof Kozlowski wrote:
>> On 18/07/2022 13:49, Ivan Bornyakov wrote:
>>> Add Device Tree Binding doc for Lattice ECP5 FPGA manager using slave
>>> SPI to load .bit formatted uncompressed bitstream image.
>>>
>>> Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>
>>> ---
>>>  .../bindings/fpga/lattice,ecp5-fpga-mgr.yaml  | 73 +++++++++++++++++++
>>>  1 file changed, 73 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/fpga/lattice,ecp5-fpga-mgr.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/fpga/lattice,ecp5-fpga-mgr.yaml b/Documentation/devicetree/bindings/fpga/lattice,ecp5-fpga-mgr.yaml
>>> new file mode 100644
>>> index 000000000000..bb10fd316f94
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/fpga/lattice,ecp5-fpga-mgr.yaml
>>> @@ -0,0 +1,73 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/fpga/lattice,ecp5-fpga-mgr.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Lattice ECP5 Slave SPI FPGA manager.
>>> +
>>> +maintainers:
>>> +  - Ivan Bornyakov <i.bornyakov@metrotek.ru>
>>> +
>>> +description:
>>> +  FPGA Manager capable to program Lattice ECP5 with uncompressed bitstream
>>> +  image in .bit format over SPI.
>>
>> The same question as before - you need to explain what is the hardware
>> (not Linux API or Linux subsystem).
>>
> 
> I really don't know what to say aside from "thing that capable to
> program FPGA". Is there a good exmple of proper wording in
> Documentation/devicetree/bindings/fpga/?
> Otherwise I would ask FPGA Manager framework maintainers assistance on
> how to describe a FPGA Manager driver.

I think my first reply had some leads to possible description. Is it a
piece of FPGA? Is it a programmable block of FPGA? Is it dedicated chip
on SPI line? The only problem I see with description is that word
"manager" is too generic and people can call everything manager...

Best regards,
Krzysztof
