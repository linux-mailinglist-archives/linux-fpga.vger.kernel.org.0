Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08B632F0998
	for <lists+linux-fpga@lfdr.de>; Sun, 10 Jan 2021 21:00:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbhAJT72 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 10 Jan 2021 14:59:28 -0500
Received: from mail-pg1-f177.google.com ([209.85.215.177]:39231 "EHLO
        mail-pg1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbhAJT71 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 10 Jan 2021 14:59:27 -0500
Received: by mail-pg1-f177.google.com with SMTP id 30so11237074pgr.6;
        Sun, 10 Jan 2021 11:59:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6075goJ/FktieZ0+YNncYqmQNb5fVzPo9SUqtP95ezc=;
        b=n/ipPxvnq/LNrlyYXRWsWU5DX5OhoWjXVfS+swxzTrdT5pyEBhBoiqf64XaCOs0E7D
         s8Epd6iCiIfj3ljwYytr7GOYw1OXi9NxPrkIVmEHRNYYQZ75nQl2bGNadwXOH44oudJH
         QyH8j/WNhdoydWWNe0Wf5+coYaaN/L1C62jLrGCl0TBKXXLXVoCXBON1ijNxPDcb/KTW
         TINLNa0gQWzDwHiUKuWRnxjWQlPWtEGPq+0ya7qFAZFkEnrtRm9ha/x6UZwjOWD8vf25
         Wk1Am34DxyMD6fTDqJaxJjjXIiKeoJirxxcYfgNM8O5U359TrK37MhqGPccwFA5+0/QH
         W7wA==
X-Gm-Message-State: AOAM530bFgbJ0VI4HmeP40P51NYOTrW5GVPFAu9nZi22YjqPhV6Te6D5
        lsjVIpFB24Yi3rpohEMwtREhYv8zhYo=
X-Google-Smtp-Source: ABdhPJxVbk2Pp8dtbtH3BSqzC9fy6XbitWnRNtl8GNITFcSxNKY2lX703q1VA9CjAOh9GVrua2bPaw==
X-Received: by 2002:aa7:979d:0:b029:1a4:3b76:a559 with SMTP id o29-20020aa7979d0000b02901a43b76a559mr13320736pfp.49.1610308726780;
        Sun, 10 Jan 2021 11:58:46 -0800 (PST)
Received: from localhost ([2601:647:5b00:1162:1ac0:17a6:4cc6:d1ef])
        by smtp.gmail.com with ESMTPSA id p9sm15480516pjb.3.2021.01.10.11.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jan 2021 11:58:45 -0800 (PST)
Date:   Sun, 10 Jan 2021 11:58:44 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        trix@redhat.com, lgoncalv@redhat.com, hao.wu@intel.com
Subject: Re: [PATCH v5 0/2] UIO support for dfl devices
Message-ID: <X/tcdB0hwDLog1TW@archbook>
References: <1609557182-20787-1-git-send-email-yilun.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1609557182-20787-1-git-send-email-yilun.xu@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Xu,

On Sat, Jan 02, 2021 at 11:13:00AM +0800, Xu Yilun wrote:
> This patchset supports some dfl device drivers written in userspace.
> 
> In the patchset v1, the "driver_override" interface should be used to bind
> the DFL UIO driver to DFL devices. But there is concern that the
> "driver_override" interface is not OK itself.
> 
> In v2, we use a new matching algorithem. The "driver_override" interface
> is abandoned, the DFL UIO driver matches any DFL device which could not be
> handled by other DFL drivers. So the DFL UIO driver could be used for new
> DFL devices which are not supported by kernel. The concern is the UIO may
> not be suitable as a default/generic driver for all dfl features, such as
> features with multiple interrupts.
> 
> In v4, we specify each matching device in the id_table of the UIO driver,
> just the same as other dfl drivers do. Now the UIO driver supports Ether
> Group feature. To support more DFL features, their feature ids should be
> added to the driver's id_table.

I think this is what you want, yes. Instead of doing a driver override
or such, add devices that should always be bound to UIO to a device id
table. For those you temporarily want to bind, make sure you can unbind
them and use 'new_id' or 'bind' in sysfs, similar to what sysfs does.

> 
> 
> Main changes from v1:
> - switch to the new matching algorithem. It matches DFL devices which could
>   not be handled by other DFL drivers.
> - refacor the code about device resources filling.
> - add the documentation.
> 
> Main changes from v2:
> - split the match ops changes in dfl.c to an independent patch.
> - move the declarations needed for dfl-uio-pdev from include/linux/dfl.h
>   to driver/fpga/dfl.h
> - some minor fixes.
> 
> Main changes from v3:
> - switch to specifying each matching device in the driver's id_table.
> - refactor the irq handling code.
> 
> Main changes from v4:
> - refactor the irq handling code.
> 
> Xu Yilun (2):
>   fpga: dfl: add the userspace I/O device support for DFL devices
>   Documentation: fpga: dfl: Add description for DFL UIO support
> 
>  Documentation/fpga/dfl.rst  | 24 ++++++++++++
>  drivers/fpga/Kconfig        | 10 +++++
>  drivers/fpga/Makefile       |  1 +
>  drivers/fpga/dfl-uio-pdev.c | 91 +++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 126 insertions(+)
>  create mode 100644 drivers/fpga/dfl-uio-pdev.c
> 
> -- 
> 2.7.4
> 

- Moritz
