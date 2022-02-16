Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 755F64B8DAB
	for <lists+linux-fpga@lfdr.de>; Wed, 16 Feb 2022 17:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236013AbiBPQPe (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 16 Feb 2022 11:15:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233156AbiBPQPd (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 16 Feb 2022 11:15:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3012AE05B
        for <linux-fpga@vger.kernel.org>; Wed, 16 Feb 2022 08:15:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 24103B81E61
        for <linux-fpga@vger.kernel.org>; Wed, 16 Feb 2022 16:15:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ABBDC340EC;
        Wed, 16 Feb 2022 16:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645028118;
        bh=gEZNmGcUKxBb3+HL/sabFBbYVDqbOpL6WAFmdJ+5YAo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=uile8DOB9egVzwVYrzcgE4TJdT8Wrti4ZDA+2qLIpdifQFVbp7BSai2xmtx2XzcVm
         lpUqEJ9LAFbWnyS1KOtR4IsH9idgQiLpQkc/BG0/LPkZNBnna795bxlMisb3leXdwO
         lK4chtWiIeCLi8kwxhe/nj5+6aZ19R9wP7IeqYahZlmVJ84DSMNXbwdgsr1pSH4dOu
         yz4tNEG50UJimtkYRs9lh2VtiSO/KX3X1CTTCXLt5uXRrKghhs73EVX3OpttUjpSQO
         BhghCF03mWDLj0Qgoaa7r4f2vDnPjDu9bLLAGhhKqbj1sTZlSjAKDX0NzXm1NGITbh
         sh+hkW+RWhVUQ==
Message-ID: <80a2fd80-dc44-30aa-180f-7612b59f7077@kernel.org>
Date:   Wed, 16 Feb 2022 10:15:16 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] firmware: stratix10-svc: extend SVC driver to get the
 firmware version
Content-Language: en-US
To:     Moritz Fischer <mdf@kernel.org>
Cc:     Xu Yilun <yilun.xu@intel.com>, hao.wu@intel.com, trix@redhat.com,
        linux-fpga@vger.kernel.org, Richard Gong <richard.gong@intel.com>
References: <20220125192853.1956486-1-dinguyen@kernel.org>
 <20220126010723.GA1139334@yilunxu-OptiPlex-7050>
 <5a1b6658-062c-d777-69d3-6a053d087ca6@kernel.org>
 <YfDUGD5+hqOnSNjP@epycbox.lan>
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <YfDUGD5+hqOnSNjP@epycbox.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 1/25/22 22:54, Moritz Fischer wrote:
> Dinh,
> 
> On Tue, Jan 25, 2022 at 10:31:06PM -0600, Dinh Nguyen wrote:
>>
>>
>> On 1/25/22 19:07, Xu Yilun wrote:
>>> On Tue, Jan 25, 2022 at 01:28:53PM -0600, Dinh Nguyen wrote:
>>>> From: Richard Gong <richard.gong@intel.com>
>>>>
>>>> Extend Intel service layer driver to get the firmware version running at
>>>> FPGA device. Therefore FPGA manager driver, one of Intel service layer
>>>> driver's client, can decide whether to handle the newly added bitstream
>>>> authentication function based on the retrieved firmware version.
>>>>
>>>> Acked-by: Moritz Fischr <mdf@kernel.org>
>>>
>>> This is already acked and no more change, is it? So please just ping in
>>> the original mail or add the [RESEND PATCH] prefix.
>>>
>>> The patch is good to me.
>>>
>>> Acked-by: Xu Yilun <yilun.xu@intel.com>
>>>
>>
>> Thanks, I added Moritz Acked-by: is the only change.
>>
>> Dinh
> 
> Did we traditionally take those through FPGA tree, did Greg pick those
> up?
> 


I'll take these patches through my repo and will send it up to Greg.

Dinh
