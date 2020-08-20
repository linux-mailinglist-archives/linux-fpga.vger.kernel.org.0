Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5176324AD9E
	for <lists+linux-fpga@lfdr.de>; Thu, 20 Aug 2020 06:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725793AbgHTEQG (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 20 Aug 2020 00:16:06 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36381 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbgHTEQF (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 20 Aug 2020 00:16:05 -0400
Received: by mail-pf1-f194.google.com with SMTP id m8so422424pfh.3;
        Wed, 19 Aug 2020 21:16:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=psruhL6kP2y+77pARz32ZAlvQOnrz7I/f+lDFZBZTxo=;
        b=mJNoGVuVLW/U4NhIyO1ZvmqkATW5Ur+18KXSfVQXQkVtI8Ovb9aAhPdsdxk1oYRQUV
         WerdmZ5lKcNNce2GTEBOLt/LkpJkQx2Xl5CkWETgp7vXAItuyrvuPYHgx7FYy8hC8pEd
         MB04OgZxEZjB7eAmoPI/7jn2cOWuu7K6lQAft0dU71/3WOImxeXi98THdVaEl8+d7v4j
         6SqD1NyvT/32ku40SiRejzbmfJ6VUPYRlV/AfBo1vScG+3Yn/sL5KssLZTZXCrG4hcXC
         eewU6XIN1sJgvohEOU/4NWYAxzxtWAwUWPGY0WSFwNb9B6SzMVhqxCpCDzY785focFxt
         or5Q==
X-Gm-Message-State: AOAM530UuhRneQDUgGSl8meYrd8378GLry1ANGWYrBbi+uhX3XOj1lMp
        HAscBkvOGmNC4sPwS4Ivpzg=
X-Google-Smtp-Source: ABdhPJyhVpS3P+FmZ7FaV4fi1lHj4qKf7ppMVW/5r9T//2lUwM3LH0R2PaEDygfP4lxWQN2SjEH6uA==
X-Received: by 2002:a63:4f22:: with SMTP id d34mr1211375pgb.320.1597896964343;
        Wed, 19 Aug 2020 21:16:04 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id n26sm849147pff.30.2020.08.19.21.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 21:16:03 -0700 (PDT)
Date:   Wed, 19 Aug 2020 21:16:03 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, trix@redhat.com, lgoncalv@redhat.com
Subject: Re: [PATCH v7 0/3] Modularization of DFL private feature drivers
Message-ID: <20200820041603.GC4022@epycbox.lan>
References: <1597823121-26424-1-git-send-email-yilun.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1597823121-26424-1-git-send-email-yilun.xu@intel.com>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Xu,

On Wed, Aug 19, 2020 at 03:45:18PM +0800, Xu Yilun wrote:
> This patchset makes it possible to develop independent driver modules
> for DFL private features. It also helps to leverage existing kernel
> drivers to enable some IP blocks in DFL.
> 
> Patch #1: Release the dfl mmio regions after enumeration, so that private
>           feature drivers could request mmio region in their own drivers.
> Patch #2: Introduce the dfl bus, then dfl devices could be supported by
>           independent dfl drivers.
> Patch #3: An example of the dfl driver for N3000 nios private feature.
> 
> 
> Main changes from v1:
> - Add the new Patch #1, to improve the feature id definition.
> - Change the dfl bus uevent format.
> - Change the dfl device's sysfs name format.
> - refactor dfl_dev_add()
> - Add the Patch #4 as an example of the dfl driver.
> - A lot of minor fixes for comments from Hao and Tom.
> 
> Main changes from v2:
> - Add the doc for dfl-n3000-nios driver.
> - Minor fixes for comments from Tom.
> 
> Main changes from v3:
> - improve the dfl devices' uevent format, 4 bits for type & 12 bits for id
> - change dfl_device->type to u8
> - A dedicate field in struct dfl_feature for dfl device instance.
> - error out if dfl_device already exist on dfl_devs_init().
> - Move the err log in regmap implementation, and delete
>    n3000_nios_writel/readl(), they have nothing to wrapper now.
> - Minor fixes and comments improvement.
> 
> Main changes from v4:
> - The patch "fpga: dfl: change data type of feature id to u16" is already
>    applied to for-next
> - Unify the naming of some functions in dfl.c
> - Fix the output of fec_mode sysfs inf to "no" on 10G configuration, cause
>    no FEC mode could be configured for 10G.
> - Change the N3000 Nios driver name from "dfl-n3000-nios" to "n3000-nios",
>    and also rename some structures and functions from dfl_n3000_nios_* to
>    n3000_nios_*
> - Minor fixes and comments improvement.
> 
> Main changes from v5:
> - Fix the output of fec_mode sysfs inf to "not supported" if in 10G,
>    or the firmware version major < 3.
> - The input param of dfl_devs_add() changes to
>    struct dfl_feature_platform_data.
> - Minor fixes and improves comments.
> 
> Main changes from v6:
> - Rebased to 5.9-rc1.
> - Improves comments.
> 
> Xu Yilun (3):
>   fpga: dfl: map feature mmio resources in their own feature drivers
>   fpga: dfl: create a dfl bus type to support DFL devices
>   fpga: dfl: add support for N3000 Nios private feature
> 
>  Documentation/ABI/testing/sysfs-bus-dfl            |  15 +
>  .../ABI/testing/sysfs-bus-dfl-devices-n3000-nios   |  21 +
>  Documentation/fpga/dfl-n3000-nios.rst              |  80 +++
>  Documentation/fpga/index.rst                       |   1 +
>  drivers/fpga/Kconfig                               |  11 +
>  drivers/fpga/Makefile                              |   2 +
>  drivers/fpga/dfl-n3000-nios.c                      | 542 +++++++++++++++++++++
>  drivers/fpga/dfl-pci.c                             |  24 +-
>  drivers/fpga/dfl.c                                 | 449 ++++++++++++++---
>  drivers/fpga/dfl.h                                 |  93 +++-
>  10 files changed, 1153 insertions(+), 85 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-dfl
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-dfl-devices-n3000-nios
>  create mode 100644 Documentation/fpga/dfl-n3000-nios.rst
>  create mode 100644 drivers/fpga/dfl-n3000-nios.c
> 
> -- 
> 2.7.4
> 

I'll get to your series this week, sorry for the delay.

Thanks,
Moritz
