Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2A311E04C0
	for <lists+linux-fpga@lfdr.de>; Mon, 25 May 2020 04:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388422AbgEYCeg (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 24 May 2020 22:34:36 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:14502 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388110AbgEYCeg (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 24 May 2020 22:34:36 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ecb2e6a0000>; Sun, 24 May 2020 19:33:14 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 24 May 2020 19:34:35 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 24 May 2020 19:34:35 -0700
Received: from [10.2.58.199] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 25 May
 2020 02:34:35 +0000
Subject: Re: [PATCH v2] fpga: dfl: afu: convert get_user_pages() -->
 pin_user_pages()
To:     "Wu, Hao" <hao.wu@intel.com>, Moritz Fischer <mdf@kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>
References: <20200519201449.3136033-1-jhubbard@nvidia.com>
 <64aa1494-7570-5319-b096-ea354ff20431@nvidia.com>
 <20200523205717.GA443638@epycbox.lan>
 <ccf86d21-2ecf-7873-1c30-fbea880b9081@nvidia.com>
 <DM6PR11MB38194610D744865657EEB08385B30@DM6PR11MB3819.namprd11.prod.outlook.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <4f326d89-d034-72ea-06d0-a2f9ba62bcc9@nvidia.com>
Date:   Sun, 24 May 2020 19:34:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <DM6PR11MB38194610D744865657EEB08385B30@DM6PR11MB3819.namprd11.prod.outlook.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1590373994; bh=UqIhK3yrHz4RCjr9Tqqe8Ckbi0ZVaOt+z/KBLejweaU=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=XO2qLGmcly07D+VUuZ46k3yHmfYpwrfntoxzgVPQ5z0mrHaw+pjwowIjSOf4ZPust
         25EiFUyZ50g2bpdCwUITvJixZ+CoHgRScOWT+jTmgPy88g7sVG1AZF+L+Uv1f9I4IK
         99Jr16tZxqDb9oS55lQSheIWqxt0A9qKx3lBp6UOueIm4utoHe90ZawOW1BfoXkI/m
         LzYAPHz4BDosWaf9HNP+BKmVtwDwtKnjcHFtKRCwlxgpECxsm6BU58d76S8Qgx2HLi
         T92uTmZLhtt/bHiINfrWesztz24f6kx21Eahz0WqkyEsg/IhkV54FDtR955KQOTT6B
         xM1uGg5BQxEkA==
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2020-05-24 19:25, Wu, Hao wrote:
>>>> Hi Moritz and FPGA developers,
>>>>
>>>> Is this OK? And if so, is it going into your git tree? Or should I
>>>> send it up through a different tree? (I'm new to the FPGA development
>>>> model).
>>>
>>> I can take it, sorry for sluggish response.
>>>
>>
>> That's great news, thanks Moritz! Sorry to be pushy, just didn't want it
>> to get lost. :)
> 
> Thanks John for this patch, and thanks Moritz for taking care of this.
> Sorry for late response, one thing here we may need to be careful is
> a recent bug fixing patch, that fixing patch has been merged by Greg
> in char-misc-next tree, and may have some conflict with this one.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git/commit/?h=char-misc-next&id=c9d7e3da1f3c4cf5dddfc5d7ce4d76d013aba1cc
> fpga: dfl: afu: Corrected error handling levels
> 
> I guess we need to rebase this patch on top of it?
> Moritz, do you have any suggestion?
> 

I'll send you a v2, rebased on top of the latest char-misc.git, no problem.

thanks,
-- 
John Hubbard
NVIDIA
