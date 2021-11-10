Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C66C344C590
	for <lists+linux-fpga@lfdr.de>; Wed, 10 Nov 2021 18:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbhKJRDA (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 10 Nov 2021 12:03:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbhKJRC7 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 10 Nov 2021 12:02:59 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B864C061764;
        Wed, 10 Nov 2021 09:00:11 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id r12so13171099edt.6;
        Wed, 10 Nov 2021 09:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n7xod9gEe9Tgy2cv6z+Vvo0Y3pvd3WiZUckMYZHz3t0=;
        b=A6lLhg04crcUzq8ML8rhppAD8VAEJV3TqYr8jNP+y0Ftj/JZWja2H0SAAVvdakzOnv
         vCWE5idBw8qMqeZXupYmF+3wBOrQao4qFXoXpX45SpDvHkajiCxTgdn69xJbUSCXzEf9
         cv0yodffJrmUbxs6FW5JrARYEomwjn82yvlOFzfQEKjOnQ9LJ01n1XhchylTYbE6ecWz
         tVWcvQyM5rWL1ZpkfgbF2wN9FpczcfWbcgACX5u4S68d1zq4zuan05IjcX+HDcGBP0SK
         QcsKHs6iPy8W3CsoZ2iRuH0wE/Z0YznKZVcuUg5UJBvoqRA5DQ4BC1xYRAz+8CqxVoux
         b3sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n7xod9gEe9Tgy2cv6z+Vvo0Y3pvd3WiZUckMYZHz3t0=;
        b=xTHol4eIECnS9fbo/Ys8jufEZW49y2CShtO8Di1V5zrrfMXHOCKnRk3sidS4QA4sbW
         shJ5Ij1eBSHJWx7XgM+sq+sOYo2LyNOKnpIyd0V1JQjF2vRskq9PCCEc46ez/AvlQg1J
         gXoRzhLs0QEQWQ61jO2XUvYG9ZPZm4S3r8XuNsU+cojZWjO8tkTc+6tPtLo4PUGcltan
         HxPlrAuPf3/13xZHKLoRsnwPs3VrI21UAxHp0DpNAjJXRtHd3BphIiQ8rVBMNubh0QKW
         5xMCcj1R59VZdNlDSBfyZL7Ku3X2n1PsqZvxQzOEi/Hna6q0/kFz+nIpErcnv2Jm6Dty
         YD7g==
X-Gm-Message-State: AOAM530A6cpjSchtwWVSyZc5GR8Ntz7UIzLL4V+FPHRblAF1owkaUUog
        UYX04HKWe+rpm0Cn92l47mh/V/sA/gsUXpDoul8=
X-Google-Smtp-Source: ABdhPJzaaYJUDX6oMBnqpbXseDShFlk9S8Ln2tmXgCn69SXXT1aXSFd2R21R59JvNjnQcFw5CmwI/15TDDd9NSCmH3s=
X-Received: by 2002:a05:6402:1801:: with SMTP id g1mr499608edy.107.1636563610047;
 Wed, 10 Nov 2021 09:00:10 -0800 (PST)
MIME-Version: 1.0
References: <20211109154127.18455-1-andriy.shevchenko@linux.intel.com>
 <8ccc133a-fb47-4548-fee3-d57775a5166d@redhat.com> <YYq4fSRoyzFE4Vei@smile.fi.intel.com>
 <39ac1f40-66ab-6c7e-0042-8fcdc062ed00@redhat.com> <YYuBz0tdduAk1c/6@smile.fi.intel.com>
 <3106bd57-9144-6a4d-8ad9-3ebf804018ab@redhat.com>
In-Reply-To: <3106bd57-9144-6a4d-8ad9-3ebf804018ab@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 10 Nov 2021 18:59:25 +0200
Message-ID: <CAHp75Vf16mH4KQ232rip9MPLoSE1TmJ_jeiwVUzqxOH5b0RFJQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] fpga: dfl: pci: Use pci_find_vsec_capability()
 when looking for DFL
To:     Tom Rix <trix@redhat.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Moritz Fischer <mdf@kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        linux-fpga@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Nov 10, 2021 at 2:28 PM Tom Rix <trix@redhat.com> wrote:
> On 11/10/21 12:24 AM, Andy Shevchenko wrote:
> > On Tue, Nov 09, 2021 at 10:27:58AM -0800, Tom Rix wrote:
> >> On 11/9/21 10:05 AM, Andy Shevchenko wrote:
> >>> On Tue, Nov 09, 2021 at 07:55:43AM -0800, Tom Rix wrote:
> >>>> On 11/9/21 7:41 AM, Andy Shevchenko wrote:
> > ...
> >
> >>>>> + voff = pci_find_vsec_capability(dev, PCI_VENDOR_ID_INTEL, PCI_VSEC_ID_INTEL_DFLS);
> >>>> This may be a weakness in the origin code, but intel isn't the exclusive
> >>>> user of DFL.
> >>> This does not change the original code. If you think so, this can be extended
> >>> later on.
> >> I would rather see this fixed now or explained why this isn't a problem.
> > This is out of scope of this change in a few ways:
> >   - we don't do 2+ things in one patch
> >   - the change doesn't change behaviour
> >   - the change is a simple cleanup
> >   - another vendor may well have quite different VSEC ID for DFL
> >
> > If you think that it should be needed, one can come up with it later on.
>
> Fixing a problem is more useful than a cleanup. The fix should come first.

What do you mean by that? The original code never worked with what you
are suggesting. There is nothing to fix in terms of "fix". What you
are proposing is a feature. And as we know the features are going into
the kernel in a natural order, means fixes - priority 1, cleanups /
refactoring as prerequisites to the feature enabling - priority 2,
feature - priority 3, other cleanups and code improvements - priority
4.

That said, the proposed change definitely falls into category 2. It
makes the proposed feature to be easily realized.

Also, do not forget that vendor specific stuff is _by definition_
vendor specific, and the proposed feature is doubtful until you prove
there is another vendor-id pair.

-- 
With Best Regards,
Andy Shevchenko
