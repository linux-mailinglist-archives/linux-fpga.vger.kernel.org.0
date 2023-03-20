Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F35DD6C1BC3
	for <lists+linux-fpga@lfdr.de>; Mon, 20 Mar 2023 17:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbjCTQdA (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 20 Mar 2023 12:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjCTQcV (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 20 Mar 2023 12:32:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2190199E6
        for <linux-fpga@vger.kernel.org>; Mon, 20 Mar 2023 09:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679329462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yKuiUgRvJgr0BMcont0ecSgYQ2TFv8+RdPWPNJF4zVg=;
        b=Owjbtfol9gupKpVQpn8vr52ZHcU16LTzfSHsMgZ6BFyh9PSVfsycyaxZEXRMSVSTIohxLe
        s72bCH+snqHegJUtY/X5w6tqKKF3Zgd1aPOn0DkGg+Be2fDx1r5cHBrlNVJe2FtP2u+7YC
        kih23Lxd4zGT2pk/bPe/QFszdg44oyA=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-BJ1OzjYAOqWc7z6gYjVyuA-1; Mon, 20 Mar 2023 12:24:21 -0400
X-MC-Unique: BJ1OzjYAOqWc7z6gYjVyuA-1
Received: by mail-pj1-f69.google.com with SMTP id q99-20020a17090a1b6c00b0023f0c6c6b3dso4563173pjq.1
        for <linux-fpga@vger.kernel.org>; Mon, 20 Mar 2023 09:24:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679329460;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yKuiUgRvJgr0BMcont0ecSgYQ2TFv8+RdPWPNJF4zVg=;
        b=xdJgoVMnDNbX1tNhrikO83ksaJn0sTCRGtRaVTmXhTXyFPPIKj849qbNEy4cC4hO7E
         wRjGVtCjJDqQyfv4EGCOb01WAvmAzGLv8UjGni/ycskXnSj9xcYCzWIVuyU6cB6ahasV
         COTQdXC0GwBBaU1xu+zAcjeDiCWp3lqu87mneLdrF8mzyM6HRNvS5i0pYhXuSx7FsPiH
         YEBzAmSGbgyTjxuW/OC8X4DoiGLw90ePT5M7JY4YAGG/5naCYWGClxXLnLYTCwq2BcEB
         tTzcFDlhTdjmyrXzOYNr+5Wi4/pFkynNp5g7dx6Xbxbs/3K940WruP7Czu651HzFpsNq
         uYmg==
X-Gm-Message-State: AO0yUKWU1yDCxigrzGLCkE0QmzhLxqbtf9/L/KPDHNSdFqN3SdJoF3r+
        U12u+kwd59vj70j6LhnXeAPaqtXjPdTwrvunfEWnyILy659VZTxmvdb4acNnQRyXwJHa64DwUTC
        OO3RlLg9H8JgxbPXCgjpzYg==
X-Received: by 2002:a62:7910:0:b0:625:e77b:93b2 with SMTP id u16-20020a627910000000b00625e77b93b2mr16590852pfc.5.1679329460496;
        Mon, 20 Mar 2023 09:24:20 -0700 (PDT)
X-Google-Smtp-Source: AK7set9RPaNXkyvrZQBlHuyu3LLY2I0lqvkat9qvlTe6YR423Sg2i2SXi7nbLf5x5L1aI2JLWCb6+w==
X-Received: by 2002:a62:7910:0:b0:625:e77b:93b2 with SMTP id u16-20020a627910000000b00625e77b93b2mr16590831pfc.5.1679329460084;
        Mon, 20 Mar 2023 09:24:20 -0700 (PDT)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id g11-20020aa7818b000000b005892ea4f092sm6761949pfi.95.2023.03.20.09.24.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 09:24:19 -0700 (PDT)
Subject: Re: [PATCH] fpga: xilinx-pr-decoupler: remove unused
 xlnx_pr_decouple_read function
To:     Xu Yilun <yilun.xu@intel.com>, Michal Simek <michal.simek@amd.com>
Cc:     mdf@kernel.org, hao.wu@intel.com, michal.simek@xilinx.com,
        nathan@kernel.org, ndesaulniers@google.com,
        linux-fpga@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20230317230617.1673923-1-trix@redhat.com>
 <c8eaefed-e1fd-e0c1-7e8f-561c20632646@amd.com>
 <ZBhqutJChvRkUsRL@yilunxu-OptiPlex-7050>
From:   Tom Rix <trix@redhat.com>
Message-ID: <2dc1f25d-d621-ec04-6de5-f731f2a8bb41@redhat.com>
Date:   Mon, 20 Mar 2023 09:24:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <ZBhqutJChvRkUsRL@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 3/20/23 7:16 AM, Xu Yilun wrote:
> On 2023-03-20 at 08:40:22 +0100, Michal Simek wrote:
>>
>> On 3/18/23 00:06, Tom Rix wrote:
>>> CAUTION: This message has originated from an External Source. Please use proper judgment and caution when opening attachments, clicking links, or responding to this email.
>>>
>>>
>>> clang with W=1 reports
>>> drivers/fpga/xilinx-pr-decoupler.c:37:19: error: unused function 'xlnx_pr_decouple_read' [-Werror,-Wunused-function]
>>> static inline u32 xlnx_pr_decouple_read(const struct xlnx_pr_decoupler_data *d,
>>>                     ^
>>> This static function is not used, so remove it.
>>>
>>> Signed-off-by: Tom Rix <trix@redhat.com>
>>> ---
>>>    drivers/fpga/xilinx-pr-decoupler.c | 6 ------
>>>    1 file changed, 6 deletions(-)
>>>
>>> diff --git a/drivers/fpga/xilinx-pr-decoupler.c b/drivers/fpga/xilinx-pr-decoupler.c
>>> index 2d9c491f7be9..b6f18c07c752 100644
>>> --- a/drivers/fpga/xilinx-pr-decoupler.c
>>> +++ b/drivers/fpga/xilinx-pr-decoupler.c
>>> @@ -34,12 +34,6 @@ static inline void xlnx_pr_decoupler_write(struct xlnx_pr_decoupler_data *d,
>>>           writel(val, d->io_base + offset);
>>>    }
>>>
>>> -static inline u32 xlnx_pr_decouple_read(const struct xlnx_pr_decoupler_data *d,
>>> -                                       u32 offset)
>>> -{
>>> -       return readl(d->io_base + offset);
>>> -}
>>> -
>>>    static int xlnx_pr_decoupler_enable_set(struct fpga_bridge *bridge, bool enable)
>>>    {
>>>           int err;
>>> --
>>> 2.27.0
>>>
>> It should be fixed like this instead.
>>
>> Thanks,
>> Michal
>>
>> diff --git a/drivers/fpga/xilinx-pr-decoupler.c b/drivers/fpga/xilinx-pr-decoupler.c
>> index 2d9c491f7be9..58508f44cd49 100644
>> --- a/drivers/fpga/xilinx-pr-decoupler.c
>> +++ b/drivers/fpga/xilinx-pr-decoupler.c
>> @@ -69,7 +69,7 @@ static int xlnx_pr_decoupler_enable_show(struct
>> fpga_bridge *bridge)
>>          if (err)
>>                  return err;
>>
>> -       status = readl(priv->io_base);
>> +       status = xlnx_pr_decouple_read(priv);
> OK, I'll drop the previous fix, and waiting for the new one.

Michal,

Will you make this change ?

Tom

>
> Thanks,
> Yilun
>
>>          clk_disable(priv->clk);
>>

