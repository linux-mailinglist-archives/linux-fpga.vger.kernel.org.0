Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDB323BE51
	for <lists+linux-fpga@lfdr.de>; Tue,  4 Aug 2020 18:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbgHDQoA (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 4 Aug 2020 12:44:00 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:40183 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgHDQoA (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 4 Aug 2020 12:44:00 -0400
Received: by mail-pj1-f65.google.com with SMTP id d4so2470009pjx.5;
        Tue, 04 Aug 2020 09:43:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yuWZSG0s7bzdgOA+0VPUa0Lp1EJmf3kTDXCdwURyIzM=;
        b=lT68BkXSIOmXOr67Tm0FV4KnPqK64pqfPFVCSRp7qO/wC8l3Ug/goXok+7RCCK31MZ
         l4S1tUzKY5iWdIJuPoY0QLvDt2Qp9Q3Gfv5v3BCZmClFRY07spOABF9KnGe1Oeok5QIj
         q3/U8uKZ97SsM0o5Nj5vdD5FAbyJVDsYM8+XaVE8mbf5aUhTqgAtMi87TLo3eYKUQnGV
         zitN57NvtBBflO3wwBX18zFVLJ5wovTDe88zkKt0jGL+Yxg1U+pN/fVpmesxtvP6ENwi
         u84qOf2IEF8M07Esu4yXERslKGxm69VxEoa3wMF6Y7DceKpFI86nGRcmEvOLVr4FXkWB
         m1CQ==
X-Gm-Message-State: AOAM533YEEOsV3egvO3PHpFVg+0e4ZXU5SvmGoZfSJnLUgE2s+b0guxg
        psNNOFbmjFEbi1jhvrcIgEk=
X-Google-Smtp-Source: ABdhPJwQAdJMl4TUvT7CbHM8MU9xR/EullcnuFrqc2v93iFTMiBqfiMICZh3PHM4XFs4o0SBNpcVTw==
X-Received: by 2002:a17:90b:2388:: with SMTP id mr8mr5740417pjb.64.1596559439463;
        Tue, 04 Aug 2020 09:43:59 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id d14sm15649659pfn.161.2020.08.04.09.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 09:43:58 -0700 (PDT)
Date:   Tue, 4 Aug 2020 09:43:58 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     richard.gong@linux.intel.com
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, trix@redhat.com, dinguyen@kernel.org,
        Richard Gong <richard.gong@intel.com>
Subject: Re: [RESEND PATCHv1] fpga: stratix10-soc: make FPGA task
 un-interruptible
Message-ID: <20200804164358.GB1499313@epycbox.lan>
References: <1595607009-2065-1-git-send-email-richard.gong@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595607009-2065-1-git-send-email-richard.gong@linux.intel.com>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, Jul 24, 2020 at 11:10:09AM -0500, richard.gong@linux.intel.com wrote:
> From: Richard Gong <richard.gong@intel.com>
> 
> When CTRL+C occurs during the process of FPGA reconfiguration, the FPGA
> reconfiguration process stops and the user can't perform a new FPGA
> reconfiguration properly.
> 
> Set FPGA task to be not interruptible so that the user can properly
> perform FPGA reconfiguration after CTRL+C event.
> 
> Signed-off-by: Richard Gong <richard.gong@intel.com>
> Reviewed-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/fpga/stratix10-soc.c | 23 +++--------------------
>  1 file changed, 3 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
> index 44b7c56..657a70c 100644
> --- a/drivers/fpga/stratix10-soc.c
> +++ b/drivers/fpga/stratix10-soc.c
> @@ -196,17 +196,13 @@ static int s10_ops_write_init(struct fpga_manager *mgr,
>  	if (ret < 0)
>  		goto init_done;
>  
> -	ret = wait_for_completion_interruptible_timeout(
> +	ret = wait_for_completion_timeout(
>  		&priv->status_return_completion, S10_RECONFIG_TIMEOUT);
>  	if (!ret) {
>  		dev_err(dev, "timeout waiting for RECONFIG_REQUEST\n");
>  		ret = -ETIMEDOUT;
>  		goto init_done;
>  	}
> -	if (ret < 0) {
> -		dev_err(dev, "error (%d) waiting for RECONFIG_REQUEST\n", ret);
> -		goto init_done;
> -	}
>  
>  	ret = 0;
>  	if (!test_and_clear_bit(SVC_STATUS_OK, &priv->status)) {
> @@ -318,7 +314,7 @@ static int s10_ops_write(struct fpga_manager *mgr, const char *buf,
>  		 */
>  		wait_status = 1; /* not timed out */
>  		if (!priv->status)
> -			wait_status = wait_for_completion_interruptible_timeout(
> +			wait_status = wait_for_completion_timeout(
>  				&priv->status_return_completion,
>  				S10_BUFFER_TIMEOUT);
>  
> @@ -340,13 +336,6 @@ static int s10_ops_write(struct fpga_manager *mgr, const char *buf,
>  			ret = -ETIMEDOUT;
>  			break;
>  		}
> -		if (wait_status < 0) {
> -			ret = wait_status;
> -			dev_err(dev,
> -				"error (%d) waiting for svc layer buffers\n",
> -				ret);
> -			break;
> -		}
>  	}
>  
>  	if (!s10_free_buffers(mgr))
> @@ -372,7 +361,7 @@ static int s10_ops_write_complete(struct fpga_manager *mgr,
>  		if (ret < 0)
>  			break;
>  
> -		ret = wait_for_completion_interruptible_timeout(
> +		ret = wait_for_completion_timeout(
>  			&priv->status_return_completion, timeout);
>  		if (!ret) {
>  			dev_err(dev,
> @@ -380,12 +369,6 @@ static int s10_ops_write_complete(struct fpga_manager *mgr,
>  			ret = -ETIMEDOUT;
>  			break;
>  		}
> -		if (ret < 0) {
> -			dev_err(dev,
> -				"error (%d) waiting for RECONFIG_COMPLETED\n",
> -				ret);
> -			break;
> -		}
>  		/* Not error or timeout, so ret is # of jiffies until timeout */
>  		timeout = ret;
>  		ret = 0;
> -- 
> 2.7.4
> 

Sorry that one slipped through the cracks, will apply to for-next.

Thanks!
