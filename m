Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00AB018E06
	for <lists+linux-fpga@lfdr.de>; Thu,  9 May 2019 18:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbfEIQ2P (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 9 May 2019 12:28:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:49126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727202AbfEIQ2P (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 9 May 2019 12:28:15 -0400
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BA98217D6;
        Thu,  9 May 2019 16:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557419294;
        bh=Lo3r6wNDDWExsDlCrsz8PRoFKAFhRY2+YVQdSepHBIQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PhpBv3ITWgz5jj6W/YaFgqU0Z3P2KxPCEpcMo8uxAA/qN4c5Tx0dY53ZytcL8UlLp
         4hPc7nSjA14iIRed/Fem1pCw3YNLkN6OEpAVf2y/eKErfSaHbDHOfTUPPhpqfrKkKx
         RgHz+M1T9QkqJ4JY06uGCKE+akJKlDhY059Zqbmw=
Received: by mail-ed1-f53.google.com with SMTP id e24so2577642edq.6;
        Thu, 09 May 2019 09:28:14 -0700 (PDT)
X-Gm-Message-State: APjAAAXod85uE7nwHRdez0ER8O+tJr3mgrHuBnpKDyKj+2yngCszGyEI
        wxvIjh9pJtqQzeqYmxWMELVhRhNjlxvUtf1ehBA=
X-Google-Smtp-Source: APXvYqzEszFaSYCydmtb/zgYHwkpAS30MSyjTo39DUZGy7gGRXxvJfiqmfRWGm6pYClOBARpa7hf+XdGJeyeS9AUCrA=
X-Received: by 2002:a50:b854:: with SMTP id k20mr5122116ede.224.1557419292938;
 Thu, 09 May 2019 09:28:12 -0700 (PDT)
MIME-Version: 1.0
References: <1556528151-17221-1-git-send-email-hao.wu@intel.com> <1556528151-17221-18-git-send-email-hao.wu@intel.com>
In-Reply-To: <1556528151-17221-18-git-send-email-hao.wu@intel.com>
From:   Alan Tull <atull@kernel.org>
Date:   Thu, 9 May 2019 11:27:36 -0500
X-Gmail-Original-Message-ID: <CANk1AXRpBe=8Jh+_ZMfARSdXZmrQaN3jc0AfxoX2nP5sLESv2A@mail.gmail.com>
Message-ID: <CANk1AXRpBe=8Jh+_ZMfARSdXZmrQaN3jc0AfxoX2nP5sLESv2A@mail.gmail.com>
Subject: Re: [PATCH v2 17/18] fpga: dfl: fme: add global error reporting support
To:     Wu Hao <hao.wu@intel.com>
Cc:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Luwei Kang <luwei.kang@intel.com>,
        Ananda Ravuri <ananda.ravuri@intel.com>,
        Xu Yilun <yilun.xu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Apr 29, 2019 at 4:13 AM Wu Hao <hao.wu@intel.com> wrote:

Hi Hao,

The changes look good.  There's one easy to fix thing that Greg has
pointed out recently on another patch (below).

>
> This patch adds support for global error reporting for FPGA
> Management Engine (FME), it introduces sysfs interfaces to
> report different error detected by the hardware, and allow
> user to clear errors or inject error for testing purpose.
>
> Signed-off-by: Luwei Kang <luwei.kang@intel.com>
> Signed-off-by: Ananda Ravuri <ananda.ravuri@intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>

Acked-by: Alan Tull <atull@kernel.org>

> ---
> v2: fix issues found in sysfs doc.
>     fix returned error code issues for writable sysfs interfaces.
>     (use -EINVAL if input doesn't match error code)
>     reorder the sysfs groups in code.

> +static ssize_t revision_show(struct device *dev, struct device_attribute *attr,
> +                            char *buf)
> +{
> +       struct device *err_dev = dev->parent;
> +       void __iomem *base;
> +
> +       base = dfl_get_feature_ioaddr_by_id(err_dev, FME_FEATURE_ID_GLOBAL_ERR);
> +
> +       return scnprintf(buf, PAGE_SIZE, "%u\n", dfl_feature_revision(base));

Greg is discouraging use of scnprintf for sysfs attributes where it's
not needed [1].

Please fix this up the attributes added in this patchset.  Besides
that, looks good, I added my Ack.

Alan

> +}
> +static DEVICE_ATTR_RO(revision);

[1] https://lkml.org/lkml/2019/4/25/1050
