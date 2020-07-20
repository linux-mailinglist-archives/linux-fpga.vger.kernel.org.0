Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 989CD226E82
	for <lists+linux-fpga@lfdr.de>; Mon, 20 Jul 2020 20:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729506AbgGTSpb (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 20 Jul 2020 14:45:31 -0400
Received: from mga04.intel.com ([192.55.52.120]:44580 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729027AbgGTSpa (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 20 Jul 2020 14:45:30 -0400
IronPort-SDR: vXvXqmC98jNakaw+hx0yhYB0dX0vVRUJiNDwhdIKJrnF2pq+p00Hb571nzmewCJqFYUA3zcheC
 6ieiGweipztA==
X-IronPort-AV: E=McAfee;i="6000,8403,9688"; a="147488360"
X-IronPort-AV: E=Sophos;i="5.75,375,1589266800"; 
   d="scan'208";a="147488360"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2020 11:45:29 -0700
IronPort-SDR: 6y0+z5FCdr67qB+S3GoCrAC1V6JRCXFlZ69T8s7zVBxahrLjAvBdH0Sh/700l+jV+n2rx6p3K+
 H4b6cRG4Y+JQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,375,1589266800"; 
   d="scan'208";a="283607960"
Received: from marshy.an.intel.com (HELO [10.122.105.159]) ([10.122.105.159])
  by orsmga003.jf.intel.com with ESMTP; 20 Jul 2020 11:45:28 -0700
Subject: Re: [PATCH] fpga: stratix10-soc: make FPGA task un-interruptible
To:     mdf@kernel.org
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        dinguyen@kernel.org, richard.gong@intel.com
References: <1594138447-21488-1-git-send-email-richard.gong@linux.intel.com>
From:   Richard Gong <richard.gong@linux.intel.com>
Message-ID: <d678df9e-7f1d-8f50-e2c9-a734b60e6c9a@linux.intel.com>
Date:   Mon, 20 Jul 2020 14:00:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1594138447-21488-1-git-send-email-richard.gong@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


Hi Moritz,

Sorry for asking.

When you get chance, can you review this FPGA patch?

Regards,
Richard


On 7/7/20 11:14 AM, richard.gong@linux.intel.com wrote:
> From: Richard Gong <richard.gong@intel.com>
> 
> When CTRL+C occurs during the process of FPGA reconfiguration, the FPGA
> reconfiguration process stops and the user can't perform a new FPGA
> reconfiguration properly.
> 
> Set FPGA complete task to be not interruptible so that the user can
> properly perform FPGA reconfiguration after CTRL+C event.
> 
> Signed-off-by: Richard Gong <richard.gong@intel.com>
> ---
>   drivers/fpga/stratix10-soc.c | 23 +++--------------------
>   1 file changed, 3 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
> index 44b7c56..657a70c 100644
> --- a/drivers/fpga/stratix10-soc.c
> +++ b/drivers/fpga/stratix10-soc.c
> @@ -196,17 +196,13 @@ static int s10_ops_write_init(struct fpga_manager *mgr,
>   	if (ret < 0)
>   		goto init_done;
>   
> -	ret = wait_for_completion_interruptible_timeout(
> +	ret = wait_for_completion_timeout(
>   		&priv->status_return_completion, S10_RECONFIG_TIMEOUT);
>   	if (!ret) {
>   		dev_err(dev, "timeout waiting for RECONFIG_REQUEST\n");
>   		ret = -ETIMEDOUT;
>   		goto init_done;
>   	}
> -	if (ret < 0) {
> -		dev_err(dev, "error (%d) waiting for RECONFIG_REQUEST\n", ret);
> -		goto init_done;
> -	}
>   
>   	ret = 0;
>   	if (!test_and_clear_bit(SVC_STATUS_OK, &priv->status)) {
> @@ -318,7 +314,7 @@ static int s10_ops_write(struct fpga_manager *mgr, const char *buf,
>   		 */
>   		wait_status = 1; /* not timed out */
>   		if (!priv->status)
> -			wait_status = wait_for_completion_interruptible_timeout(
> +			wait_status = wait_for_completion_timeout(
>   				&priv->status_return_completion,
>   				S10_BUFFER_TIMEOUT);
>   
> @@ -340,13 +336,6 @@ static int s10_ops_write(struct fpga_manager *mgr, const char *buf,
>   			ret = -ETIMEDOUT;
>   			break;
>   		}
> -		if (wait_status < 0) {
> -			ret = wait_status;
> -			dev_err(dev,
> -				"error (%d) waiting for svc layer buffers\n",
> -				ret);
> -			break;
> -		}
>   	}
>   
>   	if (!s10_free_buffers(mgr))
> @@ -372,7 +361,7 @@ static int s10_ops_write_complete(struct fpga_manager *mgr,
>   		if (ret < 0)
>   			break;
>   
> -		ret = wait_for_completion_interruptible_timeout(
> +		ret = wait_for_completion_timeout(
>   			&priv->status_return_completion, timeout);
>   		if (!ret) {
>   			dev_err(dev,
> @@ -380,12 +369,6 @@ static int s10_ops_write_complete(struct fpga_manager *mgr,
>   			ret = -ETIMEDOUT;
>   			break;
>   		}
> -		if (ret < 0) {
> -			dev_err(dev,
> -				"error (%d) waiting for RECONFIG_COMPLETED\n",
> -				ret);
> -			break;
> -		}
>   		/* Not error or timeout, so ret is # of jiffies until timeout */
>   		timeout = ret;
>   		ret = 0;
> 
