Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1193723BF1B
	for <lists+linux-fpga@lfdr.de>; Tue,  4 Aug 2020 19:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbgHDRti (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 4 Aug 2020 13:49:38 -0400
Received: from mga02.intel.com ([134.134.136.20]:48308 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727902AbgHDRth (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 4 Aug 2020 13:49:37 -0400
IronPort-SDR: WEy+on+2bKgfNfaH46b/qEiN7ohlDnYZ639yl2SCULyOMsaEXm3PvRIW9es8eE9s1U4gnzrZXz
 BOX2mwmbNsBg==
X-IronPort-AV: E=McAfee;i="6000,8403,9703"; a="140285010"
X-IronPort-AV: E=Sophos;i="5.75,434,1589266800"; 
   d="scan'208";a="140285010"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2020 10:49:35 -0700
IronPort-SDR: vs6Dh4VZN5MzxpDli0i/f/kKxKwJorfoxBkdAAWGySOJ2LF6UCtnZMYCY4AIXXfQ9cLhhiuuMK
 zP3QzAo142sQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,434,1589266800"; 
   d="scan'208";a="288650237"
Received: from marshy.an.intel.com (HELO [10.122.105.159]) ([10.122.105.159])
  by orsmga003.jf.intel.com with ESMTP; 04 Aug 2020 10:49:35 -0700
Subject: Re: [RESEND PATCHv1] fpga: stratix10-soc: make FPGA task
 un-interruptible
To:     Moritz Fischer <mdf@kernel.org>
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        trix@redhat.com, dinguyen@kernel.org,
        Richard Gong <richard.gong@intel.com>
References: <1595607009-2065-1-git-send-email-richard.gong@linux.intel.com>
 <20200804164358.GB1499313@epycbox.lan>
From:   Richard Gong <richard.gong@linux.intel.com>
Message-ID: <91182a46-edcd-f4f2-3316-696a5147f5e4@linux.intel.com>
Date:   Tue, 4 Aug 2020 13:04:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200804164358.GB1499313@epycbox.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Moritz,

No problem.

Thanks you very much for applying patch to the next!

Regards,
Richard

On 8/4/20 11:43 AM, Moritz Fischer wrote:
> On Fri, Jul 24, 2020 at 11:10:09AM -0500, richard.gong@linux.intel.com wrote:
>> From: Richard Gong <richard.gong@intel.com>
>>
>> When CTRL+C occurs during the process of FPGA reconfiguration, the FPGA
>> reconfiguration process stops and the user can't perform a new FPGA
>> reconfiguration properly.
>>
>> Set FPGA task to be not interruptible so that the user can properly
>> perform FPGA reconfiguration after CTRL+C event.
>>
>> Signed-off-by: Richard Gong <richard.gong@intel.com>
>> Reviewed-by: Tom Rix <trix@redhat.com>
>> ---
>>   drivers/fpga/stratix10-soc.c | 23 +++--------------------
>>   1 file changed, 3 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
>> index 44b7c56..657a70c 100644
>> --- a/drivers/fpga/stratix10-soc.c
>> +++ b/drivers/fpga/stratix10-soc.c
>> @@ -196,17 +196,13 @@ static int s10_ops_write_init(struct fpga_manager *mgr,
>>   	if (ret < 0)
>>   		goto init_done;
>>   
>> -	ret = wait_for_completion_interruptible_timeout(
>> +	ret = wait_for_completion_timeout(
>>   		&priv->status_return_completion, S10_RECONFIG_TIMEOUT);
>>   	if (!ret) {
>>   		dev_err(dev, "timeout waiting for RECONFIG_REQUEST\n");
>>   		ret = -ETIMEDOUT;
>>   		goto init_done;
>>   	}
>> -	if (ret < 0) {
>> -		dev_err(dev, "error (%d) waiting for RECONFIG_REQUEST\n", ret);
>> -		goto init_done;
>> -	}
>>   
>>   	ret = 0;
>>   	if (!test_and_clear_bit(SVC_STATUS_OK, &priv->status)) {
>> @@ -318,7 +314,7 @@ static int s10_ops_write(struct fpga_manager *mgr, const char *buf,
>>   		 */
>>   		wait_status = 1; /* not timed out */
>>   		if (!priv->status)
>> -			wait_status = wait_for_completion_interruptible_timeout(
>> +			wait_status = wait_for_completion_timeout(
>>   				&priv->status_return_completion,
>>   				S10_BUFFER_TIMEOUT);
>>   
>> @@ -340,13 +336,6 @@ static int s10_ops_write(struct fpga_manager *mgr, const char *buf,
>>   			ret = -ETIMEDOUT;
>>   			break;
>>   		}
>> -		if (wait_status < 0) {
>> -			ret = wait_status;
>> -			dev_err(dev,
>> -				"error (%d) waiting for svc layer buffers\n",
>> -				ret);
>> -			break;
>> -		}
>>   	}
>>   
>>   	if (!s10_free_buffers(mgr))
>> @@ -372,7 +361,7 @@ static int s10_ops_write_complete(struct fpga_manager *mgr,
>>   		if (ret < 0)
>>   			break;
>>   
>> -		ret = wait_for_completion_interruptible_timeout(
>> +		ret = wait_for_completion_timeout(
>>   			&priv->status_return_completion, timeout);
>>   		if (!ret) {
>>   			dev_err(dev,
>> @@ -380,12 +369,6 @@ static int s10_ops_write_complete(struct fpga_manager *mgr,
>>   			ret = -ETIMEDOUT;
>>   			break;
>>   		}
>> -		if (ret < 0) {
>> -			dev_err(dev,
>> -				"error (%d) waiting for RECONFIG_COMPLETED\n",
>> -				ret);
>> -			break;
>> -		}
>>   		/* Not error or timeout, so ret is # of jiffies until timeout */
>>   		timeout = ret;
>>   		ret = 0;
>> -- 
>> 2.7.4
>>
> 
> Sorry that one slipped through the cracks, will apply to for-next.
> 
> Thanks!
> 
