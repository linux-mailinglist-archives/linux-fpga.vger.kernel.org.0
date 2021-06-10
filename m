Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 449F13A343F
	for <lists+linux-fpga@lfdr.de>; Thu, 10 Jun 2021 21:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbhFJTqN (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 10 Jun 2021 15:46:13 -0400
Received: from mail-pj1-f54.google.com ([209.85.216.54]:44854 "EHLO
        mail-pj1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbhFJTqM (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 10 Jun 2021 15:46:12 -0400
Received: by mail-pj1-f54.google.com with SMTP id h12-20020a17090aa88cb029016400fd8ad8so4528196pjq.3
        for <linux-fpga@vger.kernel.org>; Thu, 10 Jun 2021 12:44:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=u2UtLS2oKBbds0AgxOABVZYjdQ+/XjkGbp30crbK8zI=;
        b=K2G1R+0uFNOEnBy9CMeoriQy2mzXpFKu870twX2VGP+Naow7P96wQ3YsL4z4zxzvbH
         EXDThBWusatj33s4EvoS0Fy8435IxZwPtkpenrut3WhTghdQ94QP3ebF2NgkTOFbYaEB
         PyxYFtheBRdSELQISlfAfTJepA9Enbi3SbCkJYQNTzmlkqmo30gucxKpQzZ8foYy/XYc
         7z381JMnXeRipxm3IRUFeigi8CtQWrFfO6Bmow51/AGRKgdGsy460RVmkTwgjOMKjSdE
         JI2tQJXduuRa1ITgRWILXTUMyr7qMbzPT8YvuMVcxDJmAVMkFaxaW6XNK5jHkPl3gXNs
         hY3w==
X-Gm-Message-State: AOAM530gYYjXjwQIa9HbnBmwz2dAdA1BDe6pcKhykSho+fW83wKF4tgo
        gXKTFg53XwNQjInwLzriGTo=
X-Google-Smtp-Source: ABdhPJx3CBi3uLZMeFm3zAEdURTUFCiROylEtpXwXVH6+ZZCfKCj1kC3FaCg2DZ0CM49p6cu7gIkXQ==
X-Received: by 2002:a17:902:b209:b029:114:eb3f:f187 with SMTP id t9-20020a170902b209b0290114eb3ff187mr319973plr.69.1623354245409;
        Thu, 10 Jun 2021 12:44:05 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id ev11sm8415819pjb.36.2021.06.10.12.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 12:44:04 -0700 (PDT)
Date:   Thu, 10 Jun 2021 12:44:03 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org, trix@redhat.com,
        lgoncalv@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@intel.com, richard.gong@intel.com
Subject: Re: [PATCH v3 0/8] fpga: Populate dev_release functions
Message-ID: <YMJrgzoEzJ00YOsR@epycbox.lan>
References: <20210610193422.286835-1-russell.h.weight@intel.com>
 <f0e83bd2-4cb2-9fc8-2c6e-86a522f3afbe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0e83bd2-4cb2-9fc8-2c6e-86a522f3afbe@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, Jun 10, 2021 at 12:38:17PM -0700, Russ Weight wrote:
> I think this version of the patch is ready to go. If you agree, please
> provide a Reviewed-by or Tested-by tag.
> 
> Thanks,
> - Russ
> 
> On 6/10/21 12:34 PM, Russ Weight wrote:
> > The FPGA framework has a convention of using managed resource functions
> > to allow parent drivers to manage the data structures allocated by the
> > class drivers. They use an empty *_dev_release() function to satisfy the
> > class driver.
> >
> > This is inconsistent with linux driver model.
> >
> > These changes populate the class dev_release callback functions while
> > maintaining the current API.  Additional changes are made to maintain
> > consistency with the driver model.
> >
> > For more context on these changes, refer to this email thread:
> >
> > https://marc.info/?l=linux-fpga&m=162127412218557&w=2
> >
> > Changelog v2 -> v3:
> >   - Added Reviewed-by tags
> >   - Moved a "dev" to "parent" rename in the comment header for
> >     devm_fpga_region_create() from patch 8 to patch 5.
> >
> > Changelog v1 -> v2:
> >   - Moved the renaming of "dev" to "parent" into a separate patch each for
> >     fpga-mgr, fpga-bridge, fpga-region.
> >   - Restored the call to fpga_mgr_free() in devm_*_mgr_release() instead of 
> >     changing it to put_device().
> >   - Replaced patch "fpga: altera-pr-ip: Remove function alt_pr_unregister"
> >     with "fpga: altera-pr-ip: Remove function alt_pr_unregister". This patch
> >     removes the alt_pr_unregister() function altogether, instead of just
> >     removing portions of it.
> >
> > Russ Weight (8):
> >   fpga: altera-pr-ip: Remove function alt_pr_unregister
> >   fpga: stratix10-soc: Add missing fpga_mgr_free() call
> >   fpga: mgr: Rename dev to parent for parent device
> >   fpga: bridge: Rename dev to parent for parent device
> >   fpga: region: Rename dev to parent for parent device
> >   fpga: mgr: Use standard dev_release for class driver
> >   fpga: bridge: Use standard dev_release for class driver
> >   fpga: region: Use standard dev_release for class driver
> >
> >  drivers/fpga/altera-pr-ip-core.c       | 10 -----
> >  drivers/fpga/fpga-bridge.c             | 46 ++++++++++-----------
> >  drivers/fpga/fpga-mgr.c                | 55 ++++++++++++--------------
> >  drivers/fpga/fpga-region.c             | 44 ++++++++++-----------
> >  drivers/fpga/stratix10-soc.c           |  1 +
> >  include/linux/fpga/altera-pr-ip-core.h |  1 -
> >  6 files changed, 71 insertions(+), 86 deletions(-)
> >
> 

Series looks good to me now, I'll wait for others to chime in and pick
it up tomorrow if nobody speaks up.

Thanks for doing the work!

- Moritz
