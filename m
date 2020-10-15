Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60BA628F397
	for <lists+linux-fpga@lfdr.de>; Thu, 15 Oct 2020 15:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387703AbgJONql (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 15 Oct 2020 09:46:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49471 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729498AbgJONql (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 15 Oct 2020 09:46:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602769599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uCozRPJayXzsdVCpvZ8ffIGTYIbEnNyuAmtCfUAJ+2A=;
        b=d905vs37RIfdzxoJN4lBVdFV81jQSsYYObmpfzKhUjPwXi3Qp2FF3RKLY9rgLiqU6QFKxC
        kEk9c4lmYPnia1gprTWw4DAHMXyES2pZFjeiUCufH6QJIcoWMMs5KNgXREwZvXDMYjzDEP
        1coMKL4RVkbMSDGOaNiTsyuZHNEdotg=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-112-rz1ogndANQm_MRbyFT8rtw-1; Thu, 15 Oct 2020 09:46:37 -0400
X-MC-Unique: rz1ogndANQm_MRbyFT8rtw-1
Received: by mail-ot1-f71.google.com with SMTP id r4so951174oti.16
        for <linux-fpga@vger.kernel.org>; Thu, 15 Oct 2020 06:46:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=uCozRPJayXzsdVCpvZ8ffIGTYIbEnNyuAmtCfUAJ+2A=;
        b=Z1/pdgV+U0Cyrp5qKnFnI54ca9x4lym1E8D1QA0uwCHNLKyDvs5ytquJlGTpvyNB6P
         TQgksiGS0BcY2oRy2eIfWyhPyw6iFrtmHevIdBXGnnGWKFtJsJIMpYdnlFQf6pWbRbNJ
         ry0IFfh9E2k/k5gLMNiRtsDZcvDdYon1T+OlH4skOOJKaab8czLgTTDkde01JcDl00vs
         vboaqappjnHE1TCKtuvvgvUMQpRowk1zr/x8zRmJwBs+Zgi7uUM1CY1E8F1DiDx6wr73
         20zNOV2Q0yihUexNohLSbGwlPrjf1XM9QA7gD4nDMZK0VuE2gONZKF14ESHDCZUyTPN9
         +sAQ==
X-Gm-Message-State: AOAM533a+zlM2OCciNoF/JSJV7Ibg8TlutV5DjieSQHElXVtmi5TMgVR
        bUPP1U0uI50mtY+H2+OV43YPu+weWtGTv0WRPt4lDj8Lrkddoi3Zv9YQSyWcW9eyBfuXNZh0zBm
        BAUl1w09PCcpZv+qXQhYrbw==
X-Received: by 2002:a05:6830:1de6:: with SMTP id b6mr2761960otj.37.1602769595575;
        Thu, 15 Oct 2020 06:46:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwVQw352URDrBKs/bqRnq7mFEEVp1UVno4HCu8PoybVHyD+06YQdNLKL0RZYq74pIIvB4LsdA==
X-Received: by 2002:a05:6830:1de6:: with SMTP id b6mr2761946otj.37.1602769595308;
        Thu, 15 Oct 2020 06:46:35 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id h25sm1105625otj.41.2020.10.15.06.46.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2020 06:46:34 -0700 (PDT)
Subject: Re: [PATCH v10 0/6] add DFL bus support to MODULE_DEVICE_TABLE()
To:     Xu Yilun <yilun.xu@intel.com>, mdf@kernel.org, krzk@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, lgoncalv@redhat.com, hao.wu@intel.com
References: <1602746193-10626-1-git-send-email-yilun.xu@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <e531ddb4-61f9-6f86-0d45-8d721e114db2@redhat.com>
Date:   Thu, 15 Oct 2020 06:46:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1602746193-10626-1-git-send-email-yilun.xu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

To me, this set looks ready to go.

Tom

On 10/15/20 12:16 AM, Xu Yilun wrote:
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
>   fpga: dfl: add support for N3000 Nios private feature
>   memory: dfl-emif: add the DFL EMIF private feature driver
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

