Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1268F301148
	for <lists+linux-fpga@lfdr.de>; Sat, 23 Jan 2021 01:00:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbhAVX6u (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 22 Jan 2021 18:58:50 -0500
Received: from mail-pg1-f181.google.com ([209.85.215.181]:36351 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbhAVXxW (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 22 Jan 2021 18:53:22 -0500
Received: by mail-pg1-f181.google.com with SMTP id c132so4898368pga.3;
        Fri, 22 Jan 2021 15:53:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4DinmDlrQSUNffSSvnhv3kDOp+pzFAMmlewopINTSFo=;
        b=eGtSNKB2ruz8B1gsyFvY4oLMiUm2ioFPEoCfbihEeabhtwysQUxYGDpYhmTlAuQKaO
         G1tP8s4kwhTwWbrFKHsVjkwVvfYUZQSqH7L+v9jcGA0YKlM9YWthUszTXWCpu6G8Djns
         2bTkXL/Cka3mBrNh/Af2BlYN4PQjix1ZT+R2yauYGhrYf7j3CzACiBam8RZWpTWY+jYa
         2RyHdviGP+wr/vpj8MUPNQY3Eh0qv0K/CBBALMaNDY7Wk5S3YoyufMbf7nDww9/qNnpR
         nZ0kKwPkdLvMMIjYGbh43hT4psk9mROsg0FmA81QUO4wZ+43e5z7+LdSBQ0IhSCWBN3b
         sYag==
X-Gm-Message-State: AOAM531aCpWbIF8jLiVe9FCwZfWQktMH5C3jKjW9Bz6LcQDxzqJT59t7
        APRf5/Sd8QKP10ML79NLcSg=
X-Google-Smtp-Source: ABdhPJx9ke/EzGKS83S3dMafXYN0xNjwbizgEOp7JZu456zddaYf2jrgSXe86w3kwTVR8gabTMxSqg==
X-Received: by 2002:aa7:8f30:0:b029:1b9:9016:b389 with SMTP id y16-20020aa78f300000b02901b99016b389mr7275210pfr.80.1611359561157;
        Fri, 22 Jan 2021 15:52:41 -0800 (PST)
Received: from localhost ([2601:647:5b00:1162:1ac0:17a6:4cc6:d1ef])
        by smtp.gmail.com with ESMTPSA id m4sm9654715pgv.16.2021.01.22.15.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 15:52:40 -0800 (PST)
Date:   Fri, 22 Jan 2021 15:52:37 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     trix@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: Re: [PATCH v2] MAINTAINERS: Add FPGA SUBDEVICES
Message-ID: <YAtlRV+0FWrVoaRc@archbook>
References: <20210122192928.1651254-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210122192928.1651254-1-trix@redhat.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, Jan 22, 2021 at 11:29:28AM -0800, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> Every FPGA has several subdevices in other subsystems.
> The new FPGA subdevices section is necessary to ensure changes to
> the subdevices files get reviewed within the context of the FPGA
> subsystem.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
> v1: Add several more subdevices
> ---
>  MAINTAINERS | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 17ac5bdce521..96d6f00b0584 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6975,6 +6975,17 @@ F:	drivers/fpga/
>  F:	include/linux/fpga/
>  F:	tools/testing/selftests/drivers/fpga/
>  
> +FPGA SUBDEVICES
> +R:	Tom Rix <trix@redhat.com>
> +L:	linux-fpga@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/ABI/testing/sysfs-driver-intel-m10-bmc
> +F:	Documentation/hwmon/intel-m10-bmc-hwmon.rst
> +F:	drivers/hwmon/intel-m10-bmc-hwmon.c
> +F:	drivers/memory/dfl-emif.c
> +F:	drivers/mfd/intel-m10-bmc.c
> +F:	include/linux/mfd/intel-m10-bmc.h
> +
>  FPU EMULATOR
>  M:	Bill Metzenthen <billm@melbpc.org.au>
>  S:	Maintained
> -- 
> 2.27.0
> 
All these subsystems have maintainers, I think that's up to them.
Ideally each of those drivers behaves like a normal device in the
corresponding subsystem and the way it's implemented doesn't matter.

Plenty of other examples for that

drivers/net/ethernet/xilinx/*

for example.

- Moritz
