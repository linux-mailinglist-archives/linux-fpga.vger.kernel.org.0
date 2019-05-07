Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1782F16920
	for <lists+linux-fpga@lfdr.de>; Tue,  7 May 2019 19:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbfEGR0V (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 7 May 2019 13:26:21 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43447 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbfEGR0V (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 7 May 2019 13:26:21 -0400
Received: by mail-pg1-f196.google.com with SMTP id t22so8627975pgi.10
        for <linux-fpga@vger.kernel.org>; Tue, 07 May 2019 10:26:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7xUhKA1Djcc5MQIlR53po867qGPRwrbga/QPQ1LD+uo=;
        b=OpUrz6OiQEMrJi4kwUrzIO4yKjtPoJJhtoQDNt6KRygfu2hos923mpBWgtC68aawNa
         fCQbe+Qm1Kplfmt7OIwN2Nivw2H08ChBdm05UW+9+2t1f+kqARW8Yv44Wd0KInKQt1ss
         G0d3EAfTNUQqqmvwq3h3fIyJvQ+uXgQ12IbodVyhD8OjF5hbIczx20EuL/vu5oP8pfGA
         wE4dFxe3/Sg5C6TSHMUhWgXwSzlAYcJClF3RxDBR8vH6Q13oOVXzQJwnaUn1q5fgotE3
         8TuGfAQYdKEeSmB3paqICK8g3WTrUp8bW8un5wpRExfkTd9Kk+vYzzqt8YKSJHN5REp0
         vq+w==
X-Gm-Message-State: APjAAAWn6yPH4GH/0w3HDh0ML7QyW9fpEPiTTp+EaAOCUc2QSRXJueWm
        9wEWpLUNPxNn8QyL91M3ZqE1Rw==
X-Google-Smtp-Source: APXvYqwTXxGxLxNgRqbJh4k9xlUBPop/8tx0s1TxMCPXR+62DZUBh1S3aAKeQZ1/VXnSsdM7K3XLnw==
X-Received: by 2002:a63:90c7:: with SMTP id a190mr41979773pge.23.1557249980344;
        Tue, 07 May 2019 10:26:20 -0700 (PDT)
Received: from localhost ([2601:647:4700:2953:ec49:968:583:9f8])
        by smtp.gmail.com with ESMTPSA id h13sm14867749pgk.55.2019.05.07.10.26.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 10:26:19 -0700 (PDT)
Date:   Tue, 7 May 2019 10:26:18 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Wu Hao <hao.wu@intel.com>
Cc:     atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Xu Yilun <yilun.xu@intel.com>
Subject: Re: [PATCH v2 02/18] fpga: dfl: fme: remove copy_to_user() in ioctl
 for PR
Message-ID: <20190507172545.GA26690@archbox>
References: <1556528151-17221-1-git-send-email-hao.wu@intel.com>
 <1556528151-17221-3-git-send-email-hao.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556528151-17221-3-git-send-email-hao.wu@intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Apr 29, 2019 at 04:55:35PM +0800, Wu Hao wrote:
> This patch removes copy_to_user() code in partial reconfiguration
> ioctl, as it's useless as user never needs to read the data
> structure after ioctl.
> 
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
Acked-by: Moritz Fischer <mdf@kernel.org>
> ---
> v2: clean up code split from patch 2 in v1 patchset.
> ---
>  drivers/fpga/dfl-fme-pr.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/fpga/dfl-fme-pr.c b/drivers/fpga/dfl-fme-pr.c
> index d9ca955..6ec0f09 100644
> --- a/drivers/fpga/dfl-fme-pr.c
> +++ b/drivers/fpga/dfl-fme-pr.c
> @@ -159,9 +159,6 @@ static int fme_pr(struct platform_device *pdev, unsigned long arg)
>  	mutex_unlock(&pdata->lock);
>  free_exit:
>  	vfree(buf);
> -	if (copy_to_user((void __user *)arg, &port_pr, minsz))
> -		return -EFAULT;
> -
>  	return ret;
>  }
>  
> -- 
> 1.8.3.1
> 
