Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1BB327363
	for <lists+linux-fpga@lfdr.de>; Sun, 28 Feb 2021 17:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbhB1Q4D (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 28 Feb 2021 11:56:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24976 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229834AbhB1Q4C (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Sun, 28 Feb 2021 11:56:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614531274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xjLA4nLQuNboPUcqA+PfEQqcvf8BclIQy2K65Ac7xN0=;
        b=JdWvtbkATLrzDeCZhkIdbZzB8WUIq7UK0zsJOkQ+MsRMWRDhMLyUrU3f8UUHmLKra05Zux
        V7KtuTULsLxHBsmBLIASQrvtZr5TooxHps5HJjtTs3Ro8xsbLa2WKjhme6yu7YVibotl3Q
        J/N2jTsX3fzufEfsx9UECJdtXBQiVR0=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-ttZKiOhMOpqcm_LgmR3BAg-1; Sun, 28 Feb 2021 11:54:33 -0500
X-MC-Unique: ttZKiOhMOpqcm_LgmR3BAg-1
Received: by mail-qt1-f199.google.com with SMTP id o20so9290986qtx.22
        for <linux-fpga@vger.kernel.org>; Sun, 28 Feb 2021 08:54:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=xjLA4nLQuNboPUcqA+PfEQqcvf8BclIQy2K65Ac7xN0=;
        b=N0iCmDErBxB2ui3A2u4bvxMHfhgJb3tFvg6UlhlTIpTafP1VbotuuqsouoqH5LOtNt
         pcwbKAjfJZl5OoTkSCHhub3KvH+1P1wIrVF/HSVr6WEGXw8/hVkO/BMepqj9bPieeHUZ
         w0TNcfzahX+texl09FrPLEjTGRYV/ffPUqPmU14EQk88LI8pQO9BujFu41/rCkuFz05Y
         kc+i2KK3qDjXMou7y5SIRVTZDYKSlQgj/D+89G1vpfofCx4nbwtsewIonkfkkfSJz/yi
         Up6mgVj5i1f77CrjoeKD2m1VRqSSAiY1HChL2E0w6QzAeS7S0Z7rBykoy8V9ll/DMqcI
         5KQw==
X-Gm-Message-State: AOAM530yHigrZA22b6105Lv1KmWAbDmTnbfaqxIA+5v2H9tGc2Q3Ul7V
        dMb1BM0Ri+gWTmPX5wL0+CVaT1mftGA3CiD8pA73DZ7mJhWNRdFlCjzXVRBypZT6faagptaeT+h
        sHXzyk70er6wgUkXf9iHNyw==
X-Received: by 2002:a37:a350:: with SMTP id m77mr10921301qke.146.1614531272442;
        Sun, 28 Feb 2021 08:54:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw32NLOYnZg4CsaKO7EG+7dY3zL8r+1Y5vkqHr7/ySmieQHsLbh+nJyisNRbJY2ra4+NJlilA==
X-Received: by 2002:a37:a350:: with SMTP id m77mr10921291qke.146.1614531272237;
        Sun, 28 Feb 2021 08:54:32 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id q186sm10807279qka.56.2021.02.28.08.54.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Feb 2021 08:54:31 -0800 (PST)
Subject: Re: [PATCH V3 XRT Alveo 03/18] fpga: xrt: xclbin file helper
 functions
To:     Lizhi Hou <lizhi.hou@xilinx.com>, linux-kernel@vger.kernel.org
Cc:     linux-fpga@vger.kernel.org, maxz@xilinx.com,
        sonal.santan@xilinx.com, michal.simek@xilinx.com,
        stefanos@xilinx.com, devicetree@vger.kernel.org, mdf@kernel.org,
        robh@kernel.org, Max Zhen <max.zhen@xilinx.com>
References: <20210218064019.29189-1-lizhih@xilinx.com>
 <20210218064019.29189-4-lizhih@xilinx.com>
 <4628ef05-27d1-b92f-9126-27a1f810c608@redhat.com>
 <3b73400c-cca1-60af-4eea-ed85de77a977@xilinx.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <c79176af-8d0c-2300-3e4a-dfa604f10a62@redhat.com>
Date:   Sun, 28 Feb 2021 08:54:29 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <3b73400c-cca1-60af-4eea-ed85de77a977@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 2/26/21 1:23 PM, Lizhi Hou wrote:
> Hi Tom,
>
>
snip

>>
>> I also do not see a pragma pack, usually this is set of 1 so the compiler does not shuffle elements, increase size etc.
> This data structure is shared with other tools. And the structure is well defined with reasonable alignment. It is compatible with all compilers we have tested. So pragma pack is not necessary.

You can not have possibly tested all the configurations since the kernel supports many arches and compilers.

If the tested existing alignment is ok, pragma pack should be a noop on your tested configurations.

And help cover the untested configurations.

Tom

