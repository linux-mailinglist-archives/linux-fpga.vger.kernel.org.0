Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 796221E7DB7
	for <lists+linux-fpga@lfdr.de>; Fri, 29 May 2020 14:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgE2M72 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 29 May 2020 08:59:28 -0400
Received: from mga06.intel.com ([134.134.136.31]:31732 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726467AbgE2M71 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 29 May 2020 08:59:27 -0400
IronPort-SDR: dnSsz+tRonsbQq3XrdIfMe0DSoPm/Qdy8phi/dfwPtY9vmRnbowYN7VNLfK3KwWRmxUFHKbCnw
 5zKQYo91r9xQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2020 05:59:26 -0700
IronPort-SDR: Om36RC/qUecde2+vMMEoj3C1MUlWOQ1orM4340nBO0W+HfAv8J6eO7ggWVz1IO9OsGPg30XUYt
 7pWiaWsTaBhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,448,1583222400"; 
   d="scan'208";a="271207392"
Received: from marshy.an.intel.com (HELO [10.122.105.159]) ([10.122.105.159])
  by orsmga006.jf.intel.com with ESMTP; 29 May 2020 05:59:26 -0700
Subject: Re: [PATCHv2] fpga: stratix10-soc: remove the pre-set reconfiguration
 condition
To:     mdf@kernel.org
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        dinguyen@kernel.org, Richard Gong <richard.gong@intel.com>
References: <1589553303-7341-1-git-send-email-richard.gong@linux.intel.com>
From:   Richard Gong <richard.gong@linux.intel.com>
Message-ID: <1d9b21df-7421-b25e-5139-f297e24d99d4@linux.intel.com>
Date:   Fri, 29 May 2020 08:15:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1589553303-7341-1-git-send-email-richard.gong@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Moritz,

Sorry for asking.

When you get chance, can you review my version 2 patch submitted on 
05/15/20?

Regards,
Richard

On 5/15/20 9:35 AM, richard.gong@linux.intel.com wrote:
> From: Richard Gong <richard.gong@intel.com>
> 
> The reconfiguration mode is pre-set by driver as the full reconfiguration.
> As a result, user have to change code and recompile the drivers if he or
> she wants to perform a partial reconfiguration. Removing the pre-set
> reconfiguration condition so that user can select full or partial
> reconfiguration via overlay device tree without recompiling the drivers.
> 
> Also add an error message if the configuration request is failure.
> 
> Signed-off-by: Richard Gong <richard.gong@intel.com>
> ---
> v2: define and use constant values
> ---
>   drivers/fpga/stratix10-soc.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
> index 44b7c56..4d52a80 100644
> --- a/drivers/fpga/stratix10-soc.c
> +++ b/drivers/fpga/stratix10-soc.c
> @@ -14,9 +14,13 @@
>   /*
>    * FPGA programming requires a higher level of privilege (EL3), per the SoC
>    * design.
> + * SoC firmware supports full and partial reconfiguration.
>    */
>   #define NUM_SVC_BUFS	4
>   #define SVC_BUF_SIZE	SZ_512K
> +#define FULL_RECONFIG_FLAG	0
> +#define PARTIAL_RECONFIG_FLAG	1
> +
>   
>   /* Indicates buffer is in use if set */
>   #define SVC_BUF_LOCK	0
> @@ -182,12 +186,12 @@ static int s10_ops_write_init(struct fpga_manager *mgr,
>   	uint i;
>   	int ret;
>   
> -	ctype.flags = 0;
>   	if (info->flags & FPGA_MGR_PARTIAL_RECONFIG) {
>   		dev_dbg(dev, "Requesting partial reconfiguration.\n");
> -		ctype.flags |= BIT(COMMAND_RECONFIG_FLAG_PARTIAL);
> +		ctype.flags = PARTIAL_RECONFIG_FLAG;
>   	} else {
>   		dev_dbg(dev, "Requesting full reconfiguration.\n");
> +		ctype.flags = FULL_RECONFIG_FLAG;
>   	}
>   
>   	reinit_completion(&priv->status_return_completion);
> @@ -210,6 +214,7 @@ static int s10_ops_write_init(struct fpga_manager *mgr,
>   
>   	ret = 0;
>   	if (!test_and_clear_bit(SVC_STATUS_OK, &priv->status)) {
> +		dev_err(dev, "RECONFIG_REQUEST failed\n");
>   		ret = -ETIMEDOUT;
>   		goto init_done;
>   	}
> 
