Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3B121A964
	for <lists+linux-fpga@lfdr.de>; Thu,  9 Jul 2020 22:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbgGIUzJ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 9 Jul 2020 16:55:09 -0400
Received: from mga06.intel.com ([134.134.136.31]:2172 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726213AbgGIUzJ (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 9 Jul 2020 16:55:09 -0400
IronPort-SDR: LWOGeAzAlAhrmuL5nF7mn9GzDWA4tEkq3EgW38pgefhtj5UPsOEvVoXBra9RSbdrzTVW6iwZyH
 0sai1ZcLHmtA==
X-IronPort-AV: E=McAfee;i="6000,8403,9677"; a="209632913"
X-IronPort-AV: E=Sophos;i="5.75,332,1589266800"; 
   d="scan'208";a="209632913"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2020 13:55:08 -0700
IronPort-SDR: 31zyjENiltHuZKjrhXOmWxeNIKVfuhcaMufjTfk/WyBFCmSSzFpSpv4+pS2Z/pkelSdoipuS52
 ky4bJLPLY9aQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,332,1589266800"; 
   d="scan'208";a="280422688"
Received: from marshy.an.intel.com (HELO [10.122.105.159]) ([10.122.105.159])
  by orsmga003.jf.intel.com with ESMTP; 09 Jul 2020 13:55:07 -0700
Subject: Re: [PATCH] fpga: stratix10-soc: make FPGA task un-interruptible
To:     Tom Rix <trix@redhat.com>, mdf@kernel.org
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        dinguyen@kernel.org, richard.gong@intel.com
References: <1594138447-21488-1-git-send-email-richard.gong@linux.intel.com>
 <926c1117-1f31-5b3d-55af-4216db4f1745@redhat.com>
From:   Richard Gong <richard.gong@linux.intel.com>
Message-ID: <283c922f-12a7-ccfc-2165-219fb5fe6999@linux.intel.com>
Date:   Thu, 9 Jul 2020 16:10:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <926c1117-1f31-5b3d-55af-4216db4f1745@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Tom,

On 7/9/20 3:01 PM, Tom Rix wrote:
> Mostly fine, see inline question.
> 
> On 7/7/20 9:14 AM, richard.gong@linux.intel.com wrote:
>> From: Richard Gong <richard.gong@intel.com>
>>
>> When CTRL+C occurs during the process of FPGA reconfiguration, the FPGA
>> reconfiguration process stops and the user can't perform a new FPGA
>> reconfiguration properly.
>>
>> Set FPGA complete task to be not interruptible so that the user can
>> properly perform FPGA reconfiguration after CTRL+C event.
>>
>> Signed-off-by: Richard Gong <richard.gong@intel.com>
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
> 
> This part is done in an infinite loop, is the loop still needed 
The loop is still need. FPGA manager driver need polling the completed 
status from the lower level firmware. The lower level firmware can 
return FPGA manager driver with busy, completed or error status.
> 
> Reviewed-by: Tom Rix <trix@redhat.com>
Thanks for your review!

Regards,
Richard
> 
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
> 
