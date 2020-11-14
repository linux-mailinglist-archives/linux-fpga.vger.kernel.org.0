Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A34692B2DAB
	for <lists+linux-fpga@lfdr.de>; Sat, 14 Nov 2020 15:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbgKNOes (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 14 Nov 2020 09:34:48 -0500
Received: from mga02.intel.com ([134.134.136.20]:64967 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbgKNOer (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sat, 14 Nov 2020 09:34:47 -0500
IronPort-SDR: t9hiBMKz+9PTl9Dqf/UpMIHkdhnmVWj14h0pN4XSDmJ94bCdQU+inmKlHvHtBbjg0k/TpdDdbD
 WxIMiTPKipMw==
X-IronPort-AV: E=McAfee;i="6000,8403,9804"; a="157602708"
X-IronPort-AV: E=Sophos;i="5.77,478,1596524400"; 
   d="scan'208";a="157602708"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2020 06:34:47 -0800
IronPort-SDR: yJ7JU88zcYyAw1ufi+xlJsgMY/2IZwCz24IAgY+/GfJBynjZxcYDJ95BRa687+q1at2G+Y4MrC
 L8tQsbIkZ6fA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,478,1596524400"; 
   d="scan'208";a="324307226"
Received: from marshy.an.intel.com (HELO [10.122.105.143]) ([10.122.105.143])
  by orsmga003.jf.intel.com with ESMTP; 14 Nov 2020 06:34:46 -0800
Subject: Re: [PATCHv1 4/4] fpga: stratix10-soc: entend driver for bitstream
 authentication
To:     Tom Rix <trix@redhat.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dinguyen@kernel.org, sridhar.rajagopal@intel.com,
        Richard Gong <richard.gong@intel.com>
References: <1605204403-6663-1-git-send-email-richard.gong@linux.intel.com>
 <1605204403-6663-5-git-send-email-richard.gong@linux.intel.com>
 <9bb29416-65fe-85e8-b960-23abc49352f2@redhat.com>
From:   Richard Gong <richard.gong@linux.intel.com>
Message-ID: <6ec8b5ee-9505-7863-fcb6-7e5bbe2aa963@linux.intel.com>
Date:   Sat, 14 Nov 2020 08:55:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <9bb29416-65fe-85e8-b960-23abc49352f2@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


Hi Tom.

On 11/13/20 2:31 PM, Tom Rix wrote:
> 
> On 11/12/20 10:06 AM, richard.gong@linux.intel.com wrote:
>> From: Richard Gong <richard.gong@intel.com>
>>
>> Exten FPGA manager driver to support FPGA bitstream authentication on
>> Intel SocFPGA platforms.
>>
>> Signed-off-by: Richard Gong <richard.gong@intel.com>
>> ---
>>   drivers/fpga/stratix10-soc.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
>> index 657a70c..8a59365 100644
>> --- a/drivers/fpga/stratix10-soc.c
>> +++ b/drivers/fpga/stratix10-soc.c
>> @@ -185,7 +185,10 @@ static int s10_ops_write_init(struct fpga_manager *mgr,
>>   	ctype.flags = 0;
>>   	if (info->flags & FPGA_MGR_PARTIAL_RECONFIG) {
>>   		dev_dbg(dev, "Requesting partial reconfiguration.\n");
>> -		ctype.flags |= BIT(COMMAND_RECONFIG_FLAG_PARTIAL);
>> +		ctype.flags |= FPGA_MGR_PARTIAL_RECONFIG;
> 
> The change does not match the commit log.
> 
> Add some comment like..
> 
> 'Cleanup setting of partial reconfig flag'
> 
> to cover the change.

I will make the cleanup change separately in a different patch.

Regards,
Richard


> 
> Tom
> 
>> +	} else if (info->flags & FPGA_MGR_BITSTREM_AUTHENTICATION) {
>> +		dev_dbg(dev, "Requesting bitstream authentication.\n");
>> +		ctype.flags |= FPGA_MGR_BITSTREM_AUTHENTICATION;
>>   	} else {
>>   		dev_dbg(dev, "Requesting full reconfiguration.\n");
>>   	}
> 
