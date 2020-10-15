Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F29528F6AC
	for <lists+linux-fpga@lfdr.de>; Thu, 15 Oct 2020 18:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389147AbgJOQ2O (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 15 Oct 2020 12:28:14 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38171 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388811AbgJOQ2O (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 15 Oct 2020 12:28:14 -0400
Received: by mail-pf1-f196.google.com with SMTP id 10so2340115pfp.5;
        Thu, 15 Oct 2020 09:28:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oOjK3449cLt0/+xcPzVdPRecgKP3EiL2gJkUGV7vL7A=;
        b=UonFF/2eullAct/0UpF8VUQajOM8I720RCROaXUxtNN/FiXE5uzrO7YlfR/zhzwNLw
         sM4F9V26NZLsKp1Vqwon/GVCF5GhsAroFGSkxA2mwpfT2zxya1IUrJswBeHjAF48fCqs
         r/lPQCcg7uioE72oGRvrJS1CoEr0bpIL/OY40rAwInIoICqQV5EeAGMJfhJGdYQgg2ni
         KHJt91rVrg76d9oPpaNd7YsuGnLNmSjZRtKHkCCBzJZNgfwFi/y9rKZo+1pE4AvGecYL
         Y9TopjzINoi9L0EoezjuF1VxIZ7at2IMJfR/cOH4MJ/Cr7nCe0ufJn/vGy//F/Qucs/d
         tWTw==
X-Gm-Message-State: AOAM532w8q5tJnHpa6bXlOe3O35IX2V/4YIBenvp+jLUAF1vbv6gVWRE
        u+hToVHky5woEceeiY6o5DhcifZFa6w=
X-Google-Smtp-Source: ABdhPJxZHSDSQCBwxCWe0e420IGqlP2qqAk+II05viUFn6LPqg8tfV+C2QYnTi/wFYrJxQ/JhtUogQ==
X-Received: by 2002:a62:c1c5:0:b029:155:2a10:504f with SMTP id i188-20020a62c1c50000b02901552a10504fmr4764266pfg.13.1602779293785;
        Thu, 15 Oct 2020 09:28:13 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id s67sm3953730pfb.35.2020.10.15.09.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 09:28:13 -0700 (PDT)
Date:   Thu, 15 Oct 2020 09:28:12 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     mdf@kernel.org, krzk@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        trix@redhat.com, lgoncalv@redhat.com, hao.wu@intel.com
Subject: Re: [PATCH v10 0/6] add DFL bus support to MODULE_DEVICE_TABLE()
Message-ID: <20201015162812.GA251058@epycbox.lan>
References: <1602746193-10626-1-git-send-email-yilun.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1602746193-10626-1-git-send-email-yilun.xu@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Xu,

On Thu, Oct 15, 2020 at 03:16:27PM +0800, Xu Yilun wrote:
> Patch #1 is a fix of the fields in struct dfl_device & dfl_device_id.
> 
> Patch #2, 3, 4 add dfl bus support to MODULE_DEVICE_TABLE(), they also
> move the necessary definitions in head file to public folders so that
> scatter dfl drivers could use them.
> 
> Patch #5 is the dfl driver for N3000 Nios private feature, this is the
> first use case of dfl bus.
> 
> Patch #6 is the dfl driver for DFL EMIF private feature.
> 
> 
> Main changes from v1:
> - A new patch (Patch #3) to fix the description.
> - Rename the dfl-bus.h to dfl.h
> - Updated the MAINTAINERS under FPGA DFL DRIVERS.
> - Improve comments and minor fixes.
> 
> Main changes from v2:
> - Change the bus name from "dfl" to "fpga-dfl", also rename related
>   variables, functions ...
> - Changes the data type of fpga_dfl_device_id.type from u8 to u16
> - Explicitly defines the values of enum fpga_dfl_id_type
> - Delete the comments for the valid bits of type & feature_id
> - changes MODALIAS format for fpga dfl devices
> 
> Main changes from v3:
> - Change the bus name back to "dfl".
> - Add 2 patches (#5, 6) for dfl drivers.
> - Delete the retimer FEC mode configuration via module_parameter for
>   Patch #5
> - Merge the patch "Make m10_n3000_info static" (https://lore.kernel.org/linux-fpga/52d8411e-13d8-1e91-756d-131802f5f445@huawei.com/T/#t)
>   into Patch #5
> - Add static prefix for emif attributes macro for Patch #6
> 
> Main changes from v9:
> - Add the description for struct dfl_device_id in mod_devicetable.h
> - Move the dfl.h from include/linux/fpga to include/linux
> - some code refactor and minor fixes for dfl-n3000-nios
> 
> Xu Yilun (6):
>   fpga: dfl: fix the definitions of type & feature_id for dfl devices
>   fpga: dfl: move dfl_device_id to mod_devicetable.h
>   fpga: dfl: add dfl bus support to MODULE_DEVICE_TABLE()
>   fpga: dfl: move dfl bus related APIs to include/linux/dfl.h

I'll put those on a branch (merged into for-next) so I can provide a tag
to Krzysztof once Greg pulled them in.
>   fpga: dfl: add support for N3000 Nios private feature

>   memory: dfl-emif: add the DFL EMIF private feature driver
Krzysztof will pick that one up through his tree then.
> 
>  .../ABI/testing/sysfs-bus-dfl-devices-emif         |  25 +
>  .../ABI/testing/sysfs-bus-dfl-devices-n3000-nios   |  47 ++
>  MAINTAINERS                                        |   3 +-
>  drivers/fpga/Kconfig                               |  11 +
>  drivers/fpga/Makefile                              |   2 +
>  drivers/fpga/dfl-n3000-nios.c                      | 588 +++++++++++++++++++++
>  drivers/fpga/dfl.c                                 |   4 +-
>  drivers/fpga/dfl.h                                 |  85 +--
>  drivers/memory/Kconfig                             |   9 +
>  drivers/memory/Makefile                            |   2 +
>  drivers/memory/dfl-emif.c                          | 207 ++++++++
>  include/linux/dfl.h                                |  86 +++
>  include/linux/mod_devicetable.h                    |  24 +
>  scripts/mod/devicetable-offsets.c                  |   4 +
>  scripts/mod/file2alias.c                           |  13 +
>  15 files changed, 1023 insertions(+), 87 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-dfl-devices-emif
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-dfl-devices-n3000-nios
>  create mode 100644 drivers/fpga/dfl-n3000-nios.c
>  create mode 100644 drivers/memory/dfl-emif.c
>  create mode 100644 include/linux/dfl.h
> 
> -- 
> 2.7.4
> 
Thanks,
Moritz
