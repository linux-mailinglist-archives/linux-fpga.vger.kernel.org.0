Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8522D14B5
	for <lists+linux-fpga@lfdr.de>; Mon,  7 Dec 2020 16:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725781AbgLGP2W (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 7 Dec 2020 10:28:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50116 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726196AbgLGP2W (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 7 Dec 2020 10:28:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607354815;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OBuR/RJNJ26452jAgu/4WlN7ISqdiXPS/efDMfyU81w=;
        b=KVHzyRcp8y0T5/zBOsMes6UuPbTrRUA4xITYShCwfcjODW8unGi1apLlvzuPf+/wIqEYxm
        Od7x83XEnSAjs9IN5WghRT/4fGcR4aChBuQAlvrdiuRuNe2Lo6l75IfXLqwhV6TlqrYt/7
        MoVeyI0+aMYYoypa1DCnzIx66aF51dU=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-lQhmGb_jPMOIhebnb3ebQg-1; Mon, 07 Dec 2020 10:26:48 -0500
X-MC-Unique: lQhmGb_jPMOIhebnb3ebQg-1
Received: by mail-qk1-f199.google.com with SMTP id n190so3420463qkf.18
        for <linux-fpga@vger.kernel.org>; Mon, 07 Dec 2020 07:26:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=OBuR/RJNJ26452jAgu/4WlN7ISqdiXPS/efDMfyU81w=;
        b=PC+GQeGdcG+mzwp5H2rSlZ5J/eIvcPuRdffFIitvq3cfJ+t5VPpmw3LIQq0PsGXCAj
         //GcjaDFAeV6Hg0wIwsisceIDPvDEDwJXH6EpfEBCRjLnSF6alTLayEqCSLMVXF1KANI
         Zj9uoquBeYWS46PBPz/L0SV017MNUvpm4e508tifPKWdhZ3PXZcU/gnW3cYqM9pX1ukn
         agaFo2HY+Gu8BYPVqyv2UJEPYdbDYSUTVODpH06tKVauqyUqltv+7sr5djlVsLAqHmhL
         7ZVJaVXZyNHmO9olva/THRNUHW2SAGoufgV6UGTKpb9h4s8ej8EdFuW/vDOmC7GMnu53
         BKkA==
X-Gm-Message-State: AOAM5336+8RoqfN+F9nsEWxPUJg92aabTSUXav2wo8ul/5JxUDLAlBnL
        KCXHsxvbnW7X6w8g8Q3ROo3k1boNJ3rk2BwjrSeDlHDyIGpdUagnU09H+GRPpyLXSzcpkId18Wx
        K3tZrAJbMJkgOCz+MGSv4iw==
X-Received: by 2002:ac8:5750:: with SMTP id 16mr24381045qtx.305.1607354807682;
        Mon, 07 Dec 2020 07:26:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwDTcSH/J7HhHxdQMICJ9UKAoj2ZQE6f4ymRRE0nXekdQZ8aBG+uJSFf5nwNToLc8w+Jq/xhg==
X-Received: by 2002:ac8:5750:: with SMTP id 16mr24381033qtx.305.1607354807494;
        Mon, 07 Dec 2020 07:26:47 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id m190sm6587894qkd.54.2020.12.07.07.26.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Dec 2020 07:26:46 -0800 (PST)
Subject: Re: [RESEND PATCH v13 0/6] add DFL bus support to
 MODULE_DEVICE_TABLE()
To:     Xu Yilun <yilun.xu@intel.com>, mdf@kernel.org, krzk@kernel.org,
        gregkh@linuxfoundation.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com, hao.wu@intel.com
References: <1606977360-4421-1-git-send-email-yilun.xu@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <4738579b-dfab-a7bd-ec97-cbc682445538@redhat.com>
Date:   Mon, 7 Dec 2020 07:26:44 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <1606977360-4421-1-git-send-email-yilun.xu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


> Main changes from v12:
> - For patch #5, fix the wrong use of logical'||', should use '|'

This set has not changed in a while, looks like it is just patch 5/6 that needs ack-ed.

Tom

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

