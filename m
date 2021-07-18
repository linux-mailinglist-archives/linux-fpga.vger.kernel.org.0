Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 810093CC9B6
	for <lists+linux-fpga@lfdr.de>; Sun, 18 Jul 2021 17:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233950AbhGRPLr (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 18 Jul 2021 11:11:47 -0400
Received: from mail-pj1-f47.google.com ([209.85.216.47]:35803 "EHLO
        mail-pj1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232895AbhGRPLr (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 18 Jul 2021 11:11:47 -0400
Received: by mail-pj1-f47.google.com with SMTP id gp5-20020a17090adf05b0290175c085e7a5so5186260pjb.0;
        Sun, 18 Jul 2021 08:08:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4zq80uEtE5BBY4R3qEiD4+J935URhD9frNVaQc5xESk=;
        b=JoPwc+Tp/TuFzYX5fYP+BPp48Z6q0xZULETotGBZcZk9DhMCuTDOZGwbPWxIgr8Sle
         XNTTqwlgwSUQg6WaWBkb/7U+NwdQt7lhBce5b46WUQqxWVIKB3ZhDOHlxOqBhtonpAWj
         5OeuGfYp1QOHwOW/eXLgPcDekSI9LomYqGsQyNawDd2Urpm9VksntutOVE0z0/eqKIk0
         n9/WOdqsdVKasG6yW4MOQXrEtR/fgtrJh5Ntyt2Ne2oJEcCXB5WFnFIb85fbLksXqx/d
         nnbH+ZVouRCqcYyvHk9hY7PRwoJFQTnXEE1y8rKmxdFJugTdrm2wnYbEAXcbcDl2DUwy
         d4gQ==
X-Gm-Message-State: AOAM531bXKPUOVe89WJKs5nu79mlY6jRcEUjgx/MPzmBt/FDxh85s/ag
        iw+jUSjcEg5SyAAr2C8fq10=
X-Google-Smtp-Source: ABdhPJwBWQU4uhGsNRdgKws1foJV/PHgABwGPtiR4POfUFXAth50N47yKiUgnKw2jAaJ3WiMXMG8DA==
X-Received: by 2002:a17:90a:dc0a:: with SMTP id i10mr20352871pjv.136.1626620927883;
        Sun, 18 Jul 2021 08:08:47 -0700 (PDT)
Received: from localhost ([2601:647:5b00:6f70:be34:681b:b1e9:776f])
        by smtp.gmail.com with ESMTPSA id v23sm16793602pje.33.2021.07.18.08.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jul 2021 08:08:46 -0700 (PDT)
Date:   Sun, 18 Jul 2021 08:08:45 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     trix@redhat.com
Cc:     hao.wu@intel.com, mdf@kernel.org, michal.simek@xilinx.com,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 0/7]  wrappers for fpga_manager_ops
Message-ID: <YPRD/WPxvzI3GxmB@epycbox.lan>
References: <20210625195148.837230-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210625195148.837230-1-trix@redhat.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, Jun 25, 2021 at 12:51:40PM -0700, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> As followup from
> https://lore.kernel.org/linux-fpga/06301910-10a1-0e62-45a0-d28ab5a787ed@redhat.com/
> 
> Boards should not be required to have noop functions.
> So improve or create fpga-mgr wrappers for the fpga_manager_ops.  
> Remove the noop functions.
> Refactor fpga-mgr to use the wrappers.
> 
> Changes from
> 
> v1:
>   commit subject,log
> 
> v2:
>   rebase to next-20210623
> 
> v3:
>   remove mops check
>   add write_sg wrapper
>   drop 'fpga-mgr: collect wappers and change to inline'
> 
> Tom Rix (7):
>   fpga-mgr: wrap the write_init() op
>   fpga-mgr: make write_complete() op optional
>   fpga-mgr: wrap the write() op
>   fpga-mgr: wrap the status() op
>   fpga-mgr: wrap the state() op
>   fpga-mgr: wrap the fpga_remove() op
>   fpga-mgr: wrap the write_sg() op
> 
>  drivers/fpga/dfl-fme-mgr.c   |   6 --
>  drivers/fpga/fpga-mgr.c      | 111 +++++++++++++++++++++++------------
>  drivers/fpga/stratix10-soc.c |   6 --
>  drivers/fpga/ts73xx-fpga.c   |   6 --
>  drivers/fpga/zynqmp-fpga.c   |   7 ---
>  5 files changed, 75 insertions(+), 61 deletions(-)
> 
> -- 
> 2.26.3
> 

Appled to for-next,

Thanks
