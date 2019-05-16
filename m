Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8D720E46
	for <lists+linux-fpga@lfdr.de>; Thu, 16 May 2019 19:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbfEPRxj (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 16 May 2019 13:53:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:58088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726441AbfEPRxj (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 16 May 2019 13:53:39 -0400
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03B3E20848;
        Thu, 16 May 2019 17:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558029218;
        bh=em+LcIMo1nRKWU1S98ETA5A+61nFWT/rVEqPPgyWRiU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NhEpJ5aRPKlU2+vcItCuQ8MNSjEIf4KpFA3ceVt7flBA7xug2UpluYPEZ6FDWggwG
         DjBbNdY72lyEO2yBKmxvU4HPKi4VATQGp7L8K3vCLiz3S9n/6BdiJrVKJweH8dTQBX
         A986OZaI98o6L3m4e2KcDS1gkp4wo1snU/wmfNFY=
Received: by mail-ed1-f52.google.com with SMTP id m4so6438192edd.8;
        Thu, 16 May 2019 10:53:37 -0700 (PDT)
X-Gm-Message-State: APjAAAVeUij85gT822mBByHlhDUaq4jnh+OXcsp0gvgR6XnhHmNW8boj
        KtFo6gtJ2indAv6jNayXEwx76hvWWJ8W1f1KzVk=
X-Google-Smtp-Source: APXvYqytAu9VOj9PXAicNz313TptckgI5vyn3h4G51H3J9ziOL/EH2rkUdRE/4sTfwdgBiGqBTGyFk7WL2gjXkm+ODw=
X-Received: by 2002:a50:b854:: with SMTP id k20mr51604420ede.224.1558029216606;
 Thu, 16 May 2019 10:53:36 -0700 (PDT)
MIME-Version: 1.0
References: <1556528151-17221-1-git-send-email-hao.wu@intel.com>
 <1556528151-17221-6-git-send-email-hao.wu@intel.com> <CANk1AXQSL8k=FOLv4_rLfRHBqOi=CW=yP3O8ch4VEa25cj9+Cw@mail.gmail.com>
In-Reply-To: <CANk1AXQSL8k=FOLv4_rLfRHBqOi=CW=yP3O8ch4VEa25cj9+Cw@mail.gmail.com>
From:   Alan Tull <atull@kernel.org>
Date:   Thu, 16 May 2019 12:53:00 -0500
X-Gmail-Original-Message-ID: <CANk1AXQCp2ozUQDWz__MuiUeDLvGvrfqj3KUYmBa5Z34oxG8NQ@mail.gmail.com>
Message-ID: <CANk1AXQCp2ozUQDWz__MuiUeDLvGvrfqj3KUYmBa5Z34oxG8NQ@mail.gmail.com>
Subject: Re: [PATCH v2 05/18] Documentation: fpga: dfl: add descriptions for
 virtualization and new interfaces.
To:     Wu Hao <hao.wu@intel.com>
Cc:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Xu Yilun <yilun.xu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, May 16, 2019 at 12:36 PM Alan Tull <atull@kernel.org> wrote:
>
> On Mon, Apr 29, 2019 at 4:12 AM Wu Hao <hao.wu@intel.com> wrote:

Hi Hao,

Most of this patchset looks ready to go upstream or nearly so with
pretty straightforward changes .  Patches 17 and 18 need minor changes
and please change the scnprintf in the other patches.  The patches
that had nontrivial changes are the power and thermal ones involving
hwmon.  I'm hoping to send up the patchset minus the hwmon patches in
the next version if there's no unforseen issues.  If the hwmon patches
are ready then also, that's great, but otherwise those patches don't
need to hold up all the rest of the patchset.  How's that sound?

Alan

> >
> > This patch adds virtualization support description for DFL based
> > FPGA devices (based on PCIe SRIOV), and introductions to new
> > interfaces added by new dfl private feature drivers.
> >
> > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > Signed-off-by: Wu Hao <hao.wu@intel.com>
>
> Acked-by: Alan Tull <atull@kernel.org>
>
> Thanks,
> Alan
