Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E069389840
	for <lists+linux-fpga@lfdr.de>; Wed, 19 May 2021 22:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbhESUwA (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 19 May 2021 16:52:00 -0400
Received: from mail-pg1-f182.google.com ([209.85.215.182]:34665 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbhESUv5 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 19 May 2021 16:51:57 -0400
Received: by mail-pg1-f182.google.com with SMTP id l70so10320213pga.1;
        Wed, 19 May 2021 13:50:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jkQcEqbccTE4qD/OzmCRJGfGeaMYiKEP5vTUpymXmYQ=;
        b=o8mIE+zjnlZMhbPLitBmgqaXVwkWhnEtW4/9RlMmhABh+hEGGoR+9vFBzvsh8VWquR
         JOJTxIQFUipaUmFc+EHR1vRmb14r41lQOtGZSQ78RneuQltMn2Y6ax7YNqgceq/hKIDb
         5rfIo88UTLjZq3urWStn373U+Sv62JRaQhYWZ02p1e9YrlO+gQbHMWvbndnHbnmL/GNs
         zwOY8qAYTi2KqtevT3ZFbJati6hnHz5lD/Xc0PicqlX7AD1GjonIfYxkRcAG3zfA2X/X
         aEsZpfUHXzpJK3AZaqawQuZi1QhnTJ+rsgTfAtzrwMXORy7sOcEauxEVJm9SsL1POnXD
         mCHg==
X-Gm-Message-State: AOAM530M+CrjGMb4C1Sc5lrCjQYjcTii1MEmZvDLJdgcK13Bvdp13nHY
        Hn0hpdoVicde8asZ2j1EYzk=
X-Google-Smtp-Source: ABdhPJzLc4ZKOG7XUG7PSSaA3Jb1Inuu3GX7Mgar1hqL3N8oRSaOCsRW0uYqcMxX/uptU13/SdUVJg==
X-Received: by 2002:a65:52cd:: with SMTP id z13mr1024884pgp.330.1621457436641;
        Wed, 19 May 2021 13:50:36 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id gt23sm289614pjb.13.2021.05.19.13.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 13:50:36 -0700 (PDT)
Date:   Wed, 19 May 2021 13:50:35 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     trix@redhat.com
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] fpga: add cancel() and get_error() to update ops
Message-ID: <YKV6G+9FOgMsqQuz@epycbox.lan>
References: <20210519204318.1976186-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210519204318.1976186-1-trix@redhat.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Tom,

On Wed, May 19, 2021 at 01:43:18PM -0700, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> A user may want to cancel an update or get
> more information on when an update fails.
> Add some device ops to do these.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  include/linux/fpga/fpga-mgr.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
> index ab68280f3b4a4..31d6ebc34d87a 100644
> --- a/include/linux/fpga/fpga-mgr.h
> +++ b/include/linux/fpga/fpga-mgr.h
> @@ -111,6 +111,8 @@ struct fpga_image_info {
>   * @write: write count bytes of configuration data to the FPGA
>   * @write_sg: write the scatter list of configuration data to the FPGA
>   * @write_complete: set FPGA to operating state after writing is done
> + * @cancel: cancel the update
> + * @get_error: get extended error information
>   */
>  struct fpga_manager_update_ops {
>  	int (*write_init)(struct fpga_manager *mgr,
> @@ -120,6 +122,8 @@ struct fpga_manager_update_ops {
>  	int (*write_sg)(struct fpga_manager *mgr, struct sg_table *sgt);
>  	int (*write_complete)(struct fpga_manager *mgr,
>  			      struct fpga_image_info *info);
> +	int (*cancel)(struct fpga_manager *mgr);
> +	int (*get_error)(struct fpga_manager *mgr, u64 *err);
>  };
>  
>  /**
> -- 
> 2.26.3
> 

There is no user for this, so if we add this, we add it with code
calling it.

Thanks

- Moritz
