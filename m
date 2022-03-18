Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C075F4DD536
	for <lists+linux-fpga@lfdr.de>; Fri, 18 Mar 2022 08:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232971AbiCRH0t (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 18 Mar 2022 03:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233030AbiCRH0s (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 18 Mar 2022 03:26:48 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B972B8838;
        Fri, 18 Mar 2022 00:25:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id ECBAFCE267D;
        Fri, 18 Mar 2022 07:25:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00E7BC340E8;
        Fri, 18 Mar 2022 07:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647588327;
        bh=e+TotuW7btKYlP/RTcFASwrb6g5bD2pM9PkeeMWjr6I=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=RRBVCpXcNRfL1tYBO2ZnXlu7YUhDHCVLicl1BZKnkFpaJlRpRKynQPOskFfYCryyF
         /R0lOduaXWad5f6OvKhi+he5k4G063b0MAQN2VCV4b6OtesPzhk6et00gyGOuiJRT4
         Vj+9mRu6RKMvTk94WYWFsdDmpHZ8QgnSliSddps23XEbV+fc9J0reFYxB8/x3IfTsz
         KZMc3xhIkFfZCNODOzh4FVnJy1UcHC1LzVSayE201cn9+DtpmWTUt4d+WBSLSBVIQL
         ys/MA0LHBWkIBEGlQK6Vcn7TPdG8RfmnmPT8IpxDVJorGg04eYShsRaDA8iPP8wbAd
         Emkv5ndiNN53A==
Message-ID: <93d1365c-2943-56e0-4ba8-6a4fe6194f3b@kernel.org>
Date:   Fri, 18 Mar 2022 02:25:23 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] MAINTAINERS: add a git repo for the Stratix10 Service
 driver
Content-Language: en-US
To:     Tom Rix <trix@redhat.com>, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
References: <20220223144908.399522-1-dinguyen@kernel.org>
 <4d443650-1db3-fced-3167-e3476b6e20aa@redhat.com>
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <4d443650-1db3-fced-3167-e3476b6e20aa@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 3/15/22 06:09, Tom Rix wrote:
> 
> On 2/23/22 6:49 AM, Dinh Nguyen wrote:
>> Add a git repo entry for the Stratix10 Service driver.
>>
>> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
>> ---
>>   MAINTAINERS | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index ea3e6c914384..5752236bea80 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -9890,6 +9890,7 @@ F:    drivers/firmware/stratix10-rsu.c
>>   F:    drivers/firmware/stratix10-svc.c
>>   F:    include/linux/firmware/intel/stratix10-smc.h
>>   F:    include/linux/firmware/intel/stratix10-svc-client.h
>> +T:    git 
>> git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git
> 
> Can you check if your tree is ok ?
> 
> Tom
> 
> 
>  > git clone 
> git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git
> 
> Cloning into 'linux'...
> remote: Enumerating objects: 185, done.
> remote: Counting objects: 100% (185/185), done.
> remote: Compressing objects: 100% (4/4), done.
> remote: Total 8723742 (delta 182), reused 181 (delta 181), pack-reused 
> 8723557
> Receiving objects: 100% (8723742/8723742), 2.41 GiB | 2.78 MiB/s, done.
> Resolving deltas: 100% (7135708/7135708), done.
> warning: remote HEAD refers to nonexistent ref, unable to checkout.
> 


Hmm...seeing the issue. Not sure what's going on, will troubleshoot.

Dinh
