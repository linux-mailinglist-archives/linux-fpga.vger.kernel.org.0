Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6E0423BE45
	for <lists+linux-fpga@lfdr.de>; Tue,  4 Aug 2020 18:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729620AbgHDQmB (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 4 Aug 2020 12:42:01 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44459 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728678AbgHDQl7 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 4 Aug 2020 12:41:59 -0400
Received: by mail-pl1-f194.google.com with SMTP id w17so23333122ply.11;
        Tue, 04 Aug 2020 09:41:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e+lH+2yymCGAn/T4jnHtY/yDMRdSAccQ/lSvIbh2M9w=;
        b=qVOUPB+zEX2rPAaBOPuwE9tm+XkOi0o4kzfNL/6UJvpvdWNpu5OVkoYRnZXmXULaGq
         7HMFPTkqtdA2IYqme8c02YnYMaxIU7FTB+V7MptfFr/wZ/hPvt6C2ZyBuKnEzBtLioUW
         8Tmn3/Sxk2iR+svQWlw383+qROOB93J5tGxGuirI1uTMA+nC6qpiHWgEyYdwt4A5DJn9
         Nr3OTZuq4mA0O2fC6A6ODuCRI+ml+Yf9dK2frPp8PtWSiMvnPSpsdCkAJ3MRWjSyHA9R
         OXY6Lqtb5ZSZJ6nI1YtXENDKW8pKIROh2MMnRwhNlHvRiFmLIcXm76CHDmCqb641WMsk
         vGfA==
X-Gm-Message-State: AOAM5326DdLP1bx+MlxzSIANUCoCBzLptY8wLqV2i+izU9wM2fMFlg1a
        HhgsSeUXbmGr0gK5tcF/AJ4=
X-Google-Smtp-Source: ABdhPJzxC7yj9gBIcTQWQcMeWwBbLyiLLbHppPI+aByEZ768/nZ4vQa4BMELfKLIV17Yq92R8Ecw/w==
X-Received: by 2002:a17:90a:ff85:: with SMTP id hf5mr5177653pjb.79.1596559319003;
        Tue, 04 Aug 2020 09:41:59 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id y7sm3325976pjm.3.2020.08.04.09.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 09:41:33 -0700 (PDT)
Date:   Tue, 4 Aug 2020 09:41:33 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     trix@redhat.com
Cc:     hao.wu@intel.com, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add Tom Rix as fpga reviewer
Message-ID: <20200804164133.GA1499313@epycbox.lan>
References: <20200804162003.19402-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200804162003.19402-1-trix@redhat.com>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Tom,

On Tue, Aug 04, 2020 at 09:20:03AM -0700, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> I take care of fpga kernel and userspace for Red Hat and would
> like help out more with the mainline kernel.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ce2737b1feb5..6fdb01776413 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6805,6 +6805,7 @@ F:	drivers/net/ethernet/nvidia/*
>  
>  FPGA DFL DRIVERS
>  M:	Wu Hao <hao.wu@intel.com>
> +R:	Tom Rix <trix@redhat.com>
>  L:	linux-fpga@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/fpga/dfl.rst
> @@ -6813,6 +6814,7 @@ F:	include/uapi/linux/fpga-dfl.h
>  
>  FPGA MANAGER FRAMEWORK
>  M:	Moritz Fischer <mdf@kernel.org>
> +R:	Tom Rix <trix@redhat.com>
>  L:	linux-fpga@vger.kernel.org
>  S:	Maintained
>  W:	http://www.rocketboards.org
> -- 
> 2.18.1
> 
Acked-by: Moritz Fischer <mdf@kernel.org>

I can take the patch, can I get an Acked-by from Hao?

Thanks!

Moritz
