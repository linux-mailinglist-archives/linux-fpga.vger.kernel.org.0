Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9761149C2AE
	for <lists+linux-fpga@lfdr.de>; Wed, 26 Jan 2022 05:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbiAZEbM (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 25 Jan 2022 23:31:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbiAZEbL (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 25 Jan 2022 23:31:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91788C06161C
        for <linux-fpga@vger.kernel.org>; Tue, 25 Jan 2022 20:31:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1FBE5B81C05
        for <linux-fpga@vger.kernel.org>; Wed, 26 Jan 2022 04:31:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F242C340E3;
        Wed, 26 Jan 2022 04:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643171468;
        bh=vNv4xDwLV+a5iHHmKXJoJRClo2YsOnHwSCXV7twCfts=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TIXt1OuBprI4PjXc8yP8CvT5noXQqAAw6DlMp02D7wRkkY6r3q+ZpDifM1OSwuoJQ
         6WBlOrxSq/TJZW0ZZFuKFdHuRFdvfjO22NRy5g5QZ+67UgUZpEN/jqC9PHGC8zc/ay
         +Bl8csvG+4mZVOApZr25L/9jxK86TkFlwv+pKKA8iFUGnxURBMlS58FD95ciy2ZSMI
         uQYqnimt9+2X3rpbLDrWTeMMwPpGnDz1BEUp5UiSbgcwvVWD/KCF4U0COkhNvy5Rzv
         vzj6rPXIQyJVMIBKjkvIavDyW4Q7He/KFC+QETXoUF3c3r2QVTtTjuVK/Y0ibdcO6N
         JDG7F/Tq7w8Mw==
Message-ID: <5a1b6658-062c-d777-69d3-6a053d087ca6@kernel.org>
Date:   Tue, 25 Jan 2022 22:31:06 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] firmware: stratix10-svc: extend SVC driver to get the
 firmware version
Content-Language: en-US
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     mdf@kernel.org, hao.wu@intel.com, trix@redhat.com,
        linux-fpga@vger.kernel.org, Richard Gong <richard.gong@intel.com>
References: <20220125192853.1956486-1-dinguyen@kernel.org>
 <20220126010723.GA1139334@yilunxu-OptiPlex-7050>
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20220126010723.GA1139334@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 1/25/22 19:07, Xu Yilun wrote:
> On Tue, Jan 25, 2022 at 01:28:53PM -0600, Dinh Nguyen wrote:
>> From: Richard Gong <richard.gong@intel.com>
>>
>> Extend Intel service layer driver to get the firmware version running at
>> FPGA device. Therefore FPGA manager driver, one of Intel service layer
>> driver's client, can decide whether to handle the newly added bitstream
>> authentication function based on the retrieved firmware version.
>>
>> Acked-by: Moritz Fischr <mdf@kernel.org>
> 
> This is already acked and no more change, is it? So please just ping in
> the original mail or add the [RESEND PATCH] prefix.
> 
> The patch is good to me.
> 
> Acked-by: Xu Yilun <yilun.xu@intel.com>
> 

Thanks, I added Moritz Acked-by: is the only change.

Dinh
