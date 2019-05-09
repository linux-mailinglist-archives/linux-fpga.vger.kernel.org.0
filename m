Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E457F18C2A
	for <lists+linux-fpga@lfdr.de>; Thu,  9 May 2019 16:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfEIOl4 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 9 May 2019 10:41:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:59914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726234AbfEIOl4 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 9 May 2019 10:41:56 -0400
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A030E2173B;
        Thu,  9 May 2019 14:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557412915;
        bh=Wfj1GabWdVoULFKoG6CT8frw0TykxTd53AcRNApM0TU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dSTpkE90aqWN5gHVRcjqIZnCD3GEq5VmiaK4NaEFcN0f+J9mtqEzqiGaBcyEpNAMh
         50SmW9Q4RZiEUmPi+RvzMOKH/OOG1b0mQvyRJ3nnJq0XcVPgame5xJCYcb0RlCEyqw
         MZTy5HMRElfb3Fweomhs4nxRi051oGa/p6tZGVek=
Received: by mail-ed1-f47.google.com with SMTP id f37so2227061edb.13;
        Thu, 09 May 2019 07:41:55 -0700 (PDT)
X-Gm-Message-State: APjAAAWTudLnXQ0LLLjMS/X/oc2Cko7HJmR0u6a7uuydkV5ZQcVzFee3
        IKHz7HzjE0dTesFVwwz8KlgYR7/YkhNI09MQ1w4=
X-Google-Smtp-Source: APXvYqx1UQeeC0LITggJzVsAZ70ni/5qHB/4tt0KGr2SyrDc9s/pfLRRg2SVZ25V+mjZN/v1DknmtTiZ8MKTxBS1wRU=
X-Received: by 2002:a50:fa90:: with SMTP id w16mr4447844edr.184.1557412914233;
 Thu, 09 May 2019 07:41:54 -0700 (PDT)
MIME-Version: 1.0
References: <1556528151-17221-1-git-send-email-hao.wu@intel.com> <1556528151-17221-13-git-send-email-hao.wu@intel.com>
In-Reply-To: <1556528151-17221-13-git-send-email-hao.wu@intel.com>
From:   Alan Tull <atull@kernel.org>
Date:   Thu, 9 May 2019 09:41:18 -0500
X-Gmail-Original-Message-ID: <CANk1AXQ6mcQ2td02j2g=n5cxOri--bp3yV5t7OCgK5Rc3QVHMQ@mail.gmail.com>
Message-ID: <CANk1AXQ6mcQ2td02j2g=n5cxOri--bp3yV5t7OCgK5Rc3QVHMQ@mail.gmail.com>
Subject: Re: [PATCH v2 12/18] fpga: dfl: afu: add error reporting support.
To:     Wu Hao <hao.wu@intel.com>
Cc:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Xu Yilun <yilun.xu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Apr 29, 2019 at 4:12 AM Wu Hao <hao.wu@intel.com> wrote:
>
> Error reporting is one important private feature, it reports error
> detected on port and accelerated function unit (AFU). It introduces
> several sysfs interfaces to allow userspace to check and clear
> errors detected by hardware.
>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>

Acked-by: Alan Tull <atull@kernel.org>

Thanks!
Alan

> ---
> v2: add more error code description for error clear sysfs in doc.
>     return -EINVAL instead of -EBUSY when input error code doesn't
>     match in error clear sysfs.
> ---
>  Documentation/ABI/testing/sysfs-platform-dfl-port |  39 ++++
>  drivers/fpga/Makefile                             |   1 +
>  drivers/fpga/dfl-afu-error.c                      | 225 ++++++++++++++++++++++
>  drivers/fpga/dfl-afu-main.c                       |   4 +
>  drivers/fpga/dfl-afu.h                            |   4 +
>  5 files changed, 273 insertions(+)
>  create mode 100644 drivers/fpga/dfl-afu-error.c
