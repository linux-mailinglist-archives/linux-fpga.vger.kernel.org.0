Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E18E1DFB36
	for <lists+linux-fpga@lfdr.de>; Sat, 23 May 2020 23:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388062AbgEWVdN (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 23 May 2020 17:33:13 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:18215 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387847AbgEWVdN (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 23 May 2020 17:33:13 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ec996060000>; Sat, 23 May 2020 14:30:46 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sat, 23 May 2020 14:33:13 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sat, 23 May 2020 14:33:13 -0700
Received: from [10.2.58.199] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 23 May
 2020 21:33:12 +0000
Subject: Re: [PATCH v2] fpga: dfl: afu: convert get_user_pages() -->
 pin_user_pages()
To:     Moritz Fischer <mdf@kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>, Xu Yilun <yilun.xu@intel.com>,
        Wu Hao <hao.wu@intel.com>, <linux-fpga@vger.kernel.org>
References: <20200519201449.3136033-1-jhubbard@nvidia.com>
 <64aa1494-7570-5319-b096-ea354ff20431@nvidia.com>
 <20200523205717.GA443638@epycbox.lan>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <ccf86d21-2ecf-7873-1c30-fbea880b9081@nvidia.com>
Date:   Sat, 23 May 2020 14:33:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200523205717.GA443638@epycbox.lan>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1590269446; bh=eRMBYMwT7HglaGDS/HEjHC3APgFjhB0IGthjLynCTmg=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=ehwpCzIY1PHJCvVslMEZpX9i9geALAhsYB0Ai9tSzWSshHQesNcmokU1NBC8Frg0s
         ZtF2HW3Gw1A3OMK8nFsWXTRNfXWuHlTa3L5atA0fNOmYrApWyNw7jTlozlSQdtURNQ
         jZNLBbCQA6uyLw5ZnnWP++axkxAdyC5CANl5+7GNztlv6U1UaYpWHZKnfkyfbj9HUy
         auMjf0YjOuvSPeGhSDw3U6EyZHmbHK3ix0JLsX70YvRqjxOU9O7EzjYbsxey5TGMpF
         byqhy153HPPvYVZPy1a+XMlQTzyS+y9+K2ieNfRTBIVcdFIJr8tAVrXcP0GuXgQkpM
         cx71DUtaXT3ug==
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2020-05-23 13:57, Moritz Fischer wrote:
> On Fri, May 22, 2020 at 06:52:34PM -0700, John Hubbard wrote:
>> On 2020-05-19 13:14, John Hubbard wrote:
>>> This code was using get_user_pages_fast(), in a "Case 2" scenario
>>> (DMA/RDMA), using the categorization from [1]. That means that it's
>>> time to convert the get_user_pages_fast() + put_page() calls to
>>> pin_user_pages_fast() + unpin_user_pages() calls.
>>>
>>> There is some helpful background in [2]: basically, this is a small
>>> part of fixing a long-standing disconnect between pinning pages, and
>>> file systems' use of those pages.
>>>
>>> [1] Documentation/core-api/pin_user_pages.rst
>>>
>>> [2] "Explicit pinning of user-space pages":
>>>       https://lwn.net/Articles/807108/
>>>
>>> Cc: Xu Yilun <yilun.xu@intel.com>
>>> Cc: Wu Hao <hao.wu@intel.com>
>>> Cc: Moritz Fischer <mdf@kernel.org>
>>> Cc: linux-fpga@vger.kernel.org
>>> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
>>
>>
>> Hi Moritz and FPGA developers,
>>
>> Is this OK? And if so, is it going into your git tree? Or should I
>> send it up through a different tree? (I'm new to the FPGA development
>> model).
> 
> I can take it, sorry for sluggish response.
> 

That's great news, thanks Moritz! Sorry to be pushy, just didn't want it
to get lost. :)

thanks,
-- 
John Hubbard
NVIDIA
