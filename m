Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A707A174E6E
	for <lists+linux-fpga@lfdr.de>; Sun,  1 Mar 2020 17:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgCAQ0F (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 1 Mar 2020 11:26:05 -0500
Received: from mail-pf1-f170.google.com ([209.85.210.170]:41794 "EHLO
        mail-pf1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgCAQ0F (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 1 Mar 2020 11:26:05 -0500
Received: by mail-pf1-f170.google.com with SMTP id j9so4313711pfa.8;
        Sun, 01 Mar 2020 08:26:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xOsit2vDG3Ey3Y8MTVdftxO40n8j+Kah2l/4jX18G58=;
        b=UYWW3YGMSUNl5fUgybmCf7WFekbym92bwtfxFn0II/ac+/cI8n8NoeemeLOI4d1qQn
         ase/ljpx8RN/NpBk0zOFN9jCjXE6q0tS9Y9jG3K1V5qlKRy7jX/5xeyb/iou087PD45W
         j9vAvWOlnNvD4JTOIaygPV+8dgX2hR8xWXIEhryFRLwD+6YzRx+JsLdqz/2JNKTiGtlZ
         6p9ZP9bs+q2uC7b6NxBFAmXZa+qaXjbbWIqxizynycNSmMx2eBzZ1am5zkFTZSQfsZbX
         CR3MBY+RKPxGvWP95X/u2FQCgiWd/TDyIRZJlwt+b8HELbQ4avymGjGZo5EasgUms3MN
         +Myg==
X-Gm-Message-State: ANhLgQ0h8gqFoCf0GXElwMLF+QxA8i70uUkQeVhGo9pPqovR8kkEAPme
        znbJ/e8P+16s082sIDvHOAEHy2MqvwI=
X-Google-Smtp-Source: ADFU+vtPY1Fw4U7zOw1iMGLNsJgz3CBnu9k+YaxjcbspiC+JG0tQjwomZ1QTYHeAd3wA7CRvLACY5w==
X-Received: by 2002:a63:1744:: with SMTP id 4mr352344pgx.238.1583079964326;
        Sun, 01 Mar 2020 08:26:04 -0800 (PST)
Received: from localhost ([2601:647:5b00:710:c2fa:3aa3:193c:db86])
        by smtp.gmail.com with ESMTPSA id t7sm574919pjy.1.2020.03.01.08.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 08:26:02 -0800 (PST)
Date:   Sun, 1 Mar 2020 08:26:02 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     richard.gong@linux.intel.com
Cc:     gregkh@linuxfoundation.org, mdf@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, dinguyen@kernel.org,
        linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Richard Gong <richard.gong@intel.com>
Subject: Re: [PATCHv1 3/7] fpga: stratix10-soc: add compatible property value
 for intel agilex
Message-ID: <20200301162602.GG7593@epycbox.lan>
References: <1581696052-11540-1-git-send-email-richard.gong@linux.intel.com>
 <1581696052-11540-4-git-send-email-richard.gong@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581696052-11540-4-git-send-email-richard.gong@linux.intel.com>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, Feb 14, 2020 at 10:00:48AM -0600, richard.gong@linux.intel.com wrote:
> From: Richard Gong <richard.gong@intel.com>
> 
> Add compatible property value so we can reuse FPGA manager driver on
> Intel Agilex SoC platform.
> 
> Signed-off-by: Richard Gong <richard.gong@intel.com>
> ---
>  drivers/fpga/stratix10-soc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
> index 215d337..bac93d0 100644
> --- a/drivers/fpga/stratix10-soc.c
> +++ b/drivers/fpga/stratix10-soc.c
> @@ -482,7 +482,8 @@ static int s10_remove(struct platform_device *pdev)
>  }
>  
>  static const struct of_device_id s10_of_match[] = {
> -	{ .compatible = "intel,stratix10-soc-fpga-mgr", },
> +	{.compatible = "intel,stratix10-soc-fpga-mgr"},
> +	{.compatible = "intel,agilex-soc-fpga-mgr"},
>  	{},
>  };
>  
> -- 
> 2.7.4
> 
Applied to for-next,

Thanks
