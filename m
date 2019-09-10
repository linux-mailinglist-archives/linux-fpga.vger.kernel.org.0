Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AAA7AF1E1
	for <lists+linux-fpga@lfdr.de>; Tue, 10 Sep 2019 21:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbfIJT3U (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 10 Sep 2019 15:29:20 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38469 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbfIJT3U (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 10 Sep 2019 15:29:20 -0400
Received: by mail-pg1-f193.google.com with SMTP id d10so10239297pgo.5;
        Tue, 10 Sep 2019 12:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5sU4FATKSdq7FcyJmj+pLm2LM0y8e7tk5v+hc/S6Bwo=;
        b=otoUnmP89xn5ExMTo/yCmQM2MzKldq8+a1fHc8iH9zZUuyzjvfPW9xvg1b/+ulRY/H
         uxLSsz9xDgGHjHk0XHyyTiaB9qO7vTnEDpxfU4KtFe1XJqrUZAT2U/6mlOslIC3Fh79C
         s/VQBlrs+W/Ixahy9D0nnTa7t0/iHx4hprCDVknEbVjNeV6EHE8FKJ6I/Yd8VqtNERzz
         sf61l821JJo3y8f8hzouVcPkH1xDLTiZcjJ9Hqsl71Ti0SgYQwf83b30R9qjCayfYUpj
         hcFIAbgCXG+WEH5BdmOoP390tFFFeDINAZcs85omS6F4yY+KKQdHMneE+CZtU3ExpKKL
         f2vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=5sU4FATKSdq7FcyJmj+pLm2LM0y8e7tk5v+hc/S6Bwo=;
        b=ZsNVdCgztoww0DdBzIrK/oDyoGc0jLU381phTkcTkzCLojqQCdBu1rmj+WwUOZycLB
         nlEkWpEh/6TeotIb8Y05KBr1BAKpJQnOAUbXlSJPh8lyIWGHnL/sZhp0FghYlSz8M/L6
         tSDz5v9accgGtvypMncuTJyl/ruNqipugNg7Sd/kKSQ58z06LV4kpKuh2fXn15XlAYET
         OJv+v8AJqVI8pNXwKJyPIdEFK+f4MfnaiCHlEmXg7ocYkxfgH7jNUXeGNyEbDWYc387Y
         9g4B/vo85cU7ezG6sj9zyPhemOuLC3xZLN3WQD7uqbEJ81Xjj5jrmQqexCltn1AqhrF0
         lBpA==
X-Gm-Message-State: APjAAAUY8yvbJFkYbdYsDJz/txalm65aieYNH2ZTNFpA8TwmSr3w6SFP
        1436zXnb37DM31KsvgPeyVs=
X-Google-Smtp-Source: APXvYqxHJOAfpDxbE1hET42fE9TQK88XLgFDINMO/wv5kSZ019o6h8r3bunZzpdBLSy/8YXrhx7cIA==
X-Received: by 2002:a63:b102:: with SMTP id r2mr28964997pgf.370.1568143759346;
        Tue, 10 Sep 2019 12:29:19 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s21sm379706pjr.24.2019.09.10.12.29.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Sep 2019 12:29:18 -0700 (PDT)
Date:   Tue, 10 Sep 2019 12:29:17 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wu Hao <hao.wu@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-hwmon@vger.kernel.org, jdelvare@suse.com,
        gregkh@linuxfoundation.org, Xu Yilun <yilun.xu@intel.com>
Subject: Re: [PATCH v6 1/3] Documentation: fpga: dfl: add descriptions for
 thermal/power management interfaces
Message-ID: <20190910192917.GA1566@roeck-us.net>
References: <1568094640-4920-1-git-send-email-hao.wu@intel.com>
 <1568094640-4920-2-git-send-email-hao.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568094640-4920-2-git-send-email-hao.wu@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Sep 10, 2019 at 01:50:38PM +0800, Wu Hao wrote:
> From: Xu Yilun <yilun.xu@intel.com>
> 
> This patch add introductions to thermal/power interfaces. They are
> implemented as hwmon sysfs interfaces by thermal/power private
> feature drivers.
> 
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  Documentation/fpga/dfl.rst | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
> index 6fa483f..094fc8a 100644
> --- a/Documentation/fpga/dfl.rst
> +++ b/Documentation/fpga/dfl.rst
> @@ -108,6 +108,16 @@ More functions are exposed through sysfs
>       error reporting sysfs interfaces allow user to read errors detected by the
>       hardware, and clear the logged errors.
>  
> + Power management (dfl_fme_power hwmon)
> +     power management hwmon sysfs interfaces allow user to read power management
> +     information (power consumption, thresholds, threshold status, limits, etc.)
> +     and configure power thresholds for different throttling levels.
> +
> + Thermal management (dfl_fme_thermal hwmon)
> +     thermal management hwmon sysfs interfaces allow user to read thermal
> +     management information (current temperature, thresholds, threshold status,
> +     etc.).
> +
>  
>  FIU - PORT
>  ==========
> -- 
> 1.8.3.1
> 
