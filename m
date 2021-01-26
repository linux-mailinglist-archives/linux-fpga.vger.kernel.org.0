Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E857C303F20
	for <lists+linux-fpga@lfdr.de>; Tue, 26 Jan 2021 14:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391856AbhAZNop (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 26 Jan 2021 08:44:45 -0500
Received: from mga01.intel.com ([192.55.52.88]:33260 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405243AbhAZNol (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 26 Jan 2021 08:44:41 -0500
IronPort-SDR: nyj/eVyxZKECFe1XJ8NkTsOk6EE/NnRv2h7b7Vt9alCvOP7x1RZ8KM0G/fCZIQY+DD+8rhDm8u
 F3nhqmq3COMw==
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="198689176"
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="198689176"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2021 05:42:54 -0800
IronPort-SDR: z5HKJiY8UqzEy591AFqdOKmfurt0K0FiY4UyqrhraP4QPIWXdbbJXqlZ+agW+raRY9ZgYyel4I
 vDaZtVL0XwbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="356726394"
Received: from marshy.an.intel.com (HELO [10.122.105.143]) ([10.122.105.143])
  by orsmga006.jf.intel.com with ESMTP; 26 Jan 2021 05:42:54 -0800
Subject: Re: [PATCHv3 4/6] fpga: of-fpga-region: add authenticate-fpga-config
 property
To:     Moritz Fischer <mdf@kernel.org>
Cc:     trix@redhat.com, gregkh@linuxfoundation.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        dinguyen@kernel.org, sridhar.rajagopal@intel.com,
        Richard Gong <richard.gong@intel.com>
References: <1611608188-25621-1-git-send-email-richard.gong@linux.intel.com>
 <1611608188-25621-5-git-send-email-richard.gong@linux.intel.com>
 <YA+kQ2unznKRqp8p@epycbox.lan>
From:   Richard Gong <richard.gong@linux.intel.com>
Message-ID: <a4c874a4-fd7b-d0c3-fde0-783e52055c7b@linux.intel.com>
Date:   Tue, 26 Jan 2021 08:03:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YA+kQ2unznKRqp8p@epycbox.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


Hi Moritz,

On 1/25/21 11:10 PM, Moritz Fischer wrote:
> On Mon, Jan 25, 2021 at 02:56:26PM -0600, richard.gong@linux.intel.com wrote:
>> From: Richard Gong <richard.gong@intel.com>
>>
>> Add authenticate-fpga-config property to support FPGA bitstream
>> authentication, which makes sure a signed bitstream has valid signatures.
>>
>> Signed-off-by: Richard Gong <richard.gong@intel.com>
>> ---
>> v3: no change
>> v2: changed in alphabetical order
>> ---
>>   drivers/fpga/of-fpga-region.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/fpga/of-fpga-region.c b/drivers/fpga/of-fpga-region.c
>> index e405309..3840883 100644
>> --- a/drivers/fpga/of-fpga-region.c
>> +++ b/drivers/fpga/of-fpga-region.c
>> @@ -219,6 +219,9 @@ static struct fpga_image_info *of_fpga_region_parse_ov(
>>   	info->overlay = overlay;
>>   
>>   	/* Read FPGA region properties from the overlay */
>> +	if (of_property_read_bool(overlay, "authenticate-fpga-config"))
>> +		info->flags |= FPGA_MGR_BITSTREM_AUTHENTICATION;
>> +
> Should you check here that no new nodes are being added as you *only*
> authenticate?

Sure, I will add additional checks in next submission.

> 
>>   	if (of_property_read_bool(overlay, "partial-fpga-config"))
>>   		info->flags |= FPGA_MGR_PARTIAL_RECONFIG;
>>   
>> -- 
>> 2.7.4
>>
> 
> Thanks,
> Moritz
> 
Regards,
Richard
