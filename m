Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9E82B44B2
	for <lists+linux-fpga@lfdr.de>; Mon, 16 Nov 2020 14:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbgKPN3J (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 16 Nov 2020 08:29:09 -0500
Received: from mga11.intel.com ([192.55.52.93]:62361 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727210AbgKPN3I (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 16 Nov 2020 08:29:08 -0500
IronPort-SDR: DuVvzoQ6Any6ujegBFuLLkqu/UDGAdeSTEEYm8u1Tb8kWDULwbp02MNisOlUYmYPmvXZnCfojI
 oEZF/87s1gHA==
X-IronPort-AV: E=McAfee;i="6000,8403,9806"; a="167232510"
X-IronPort-AV: E=Sophos;i="5.77,482,1596524400"; 
   d="scan'208";a="167232510"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2020 05:29:06 -0800
IronPort-SDR: fryqlkjKT0wx4qZEbae7wf0xveDIySmbyBErit51MXeBrBc/ptD9NSIz7JSI4qwD4BdKaNZJp0
 qLewOPF3EOBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,482,1596524400"; 
   d="scan'208";a="531846785"
Received: from marshy.an.intel.com (HELO [10.122.105.143]) ([10.122.105.143])
  by fmsmga006.fm.intel.com with ESMTP; 16 Nov 2020 05:29:05 -0800
Subject: Re: [PATCHv1 3/4] dt-bindings: fpga: add authenticate-fpga-config
 property
To:     Tom Rix <trix@redhat.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dinguyen@kernel.org, sridhar.rajagopal@intel.com,
        Richard Gong <richard.gong@intel.com>
References: <1605204403-6663-1-git-send-email-richard.gong@linux.intel.com>
 <1605204403-6663-4-git-send-email-richard.gong@linux.intel.com>
 <94ccfc8d-ecf9-7782-9044-d3c0cb862118@redhat.com>
 <e7b815c1-e153-2bed-7793-0affd4d74f9e@linux.intel.com>
 <a63cb1f6-4bb4-9f7d-e1b0-8054e8d4a21b@redhat.com>
From:   Richard Gong <richard.gong@linux.intel.com>
Message-ID: <50204b8d-91dd-e1d4-45f0-9b3e21d7309b@linux.intel.com>
Date:   Mon, 16 Nov 2020 07:50:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <a63cb1f6-4bb4-9f7d-e1b0-8054e8d4a21b@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Tom,


On 11/14/20 9:59 AM, Tom Rix wrote:
> 
> On 11/14/20 6:52 AM, Richard Gong wrote:
>> Hi Tom,
>>
>>>>        prior to OS boot up.
>>>>    - encrypted-fpga-config : boolean, set if the bitstream is encrypted
>>>> +- authenticate-fpga-config : boolean, set if do bitstream authentication
>>>
>>> The list is mostly in alphabetical order so the new 'authenticate-... ' should go at the top.
>>>
>>
>> The original list is not in alphabetical order. The order of partial-fpga-config, external-fpga-config and encrypted-fpga-config here follows the implementation in the of-fpga-region.c file.
>>
>> So authenticate-fpga-config should follow the way, correct?
>>
> This is why i say 'mostly' ..
> 
> In general when listing options for a user to read, you should make it easy for them to find
> 
> the option they are looking for.  Ordering them alphabetically is an obvious but not the only
> 
> way.  I am not asking for you to fix the whole table, just what you are adding. If there is
> 
> a better way to organize them please propose the method.
> 

How about put authenticate-fpga-config above partial-fpga-config? I 
would like to group all xxx-fpga-config flags together.


Regards,
Richard

> Tom
> 
>>> Improve what you mean by 'authentication' similar to my comment in the first patch.
>>>
>>
>> Will do in the version 2 submission.
>>
>> Regards,
>> Richard
>>
>>> Tom
>>>
>>>>    - region-unfreeze-timeout-us : The maximum time in microseconds to wait for
>>>>        bridges to successfully become enabled after the region has been
>>>>        programmed.
>>>
>>
> 
