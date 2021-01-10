Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FEEC2F088A
	for <lists+linux-fpga@lfdr.de>; Sun, 10 Jan 2021 18:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbhAJRGb (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 10 Jan 2021 12:06:31 -0500
Received: from mail-pj1-f53.google.com ([209.85.216.53]:40482 "EHLO
        mail-pj1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbhAJRGb (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 10 Jan 2021 12:06:31 -0500
Received: by mail-pj1-f53.google.com with SMTP id m5so9005416pjv.5;
        Sun, 10 Jan 2021 09:06:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8IY5IQr2pqyggc5i1T5hvG5vgYZ5VEFJnU227WQCvGo=;
        b=SBzCS/JccWmjcTe4cLmYiviFgmgFO4ON3klbhuwDDNzn2j5q4mUqIGC6JlWyaHPR+1
         IWPBGrrIOvFf/htSyOttVONw6ZEnjkP5rFSGQ2cdQMfV8CH8VC/31maPdh4ZGllGe3Lj
         QNhyumOTzMWMkSAkED0TvVxSQrlNx/i9Em5DEX9UfW6pmtibjNYq3DAGC/fN6A1IB1ue
         Sjk1EhqtHkjEI02yhMVNPZvpcZVyMDwfQjTBH1uYmatYRF8T0h7WBJA7aB0dTCvH77sA
         dHUdr7zvHJE3h3X5MEvaMDQXM+Z5gI6dFjapnclb/N0OFyAeOH0ISV9vQmaZfOa1he1m
         wwwQ==
X-Gm-Message-State: AOAM532RepTGXM6QH7kjudejWpfXJm2319WRZzeMyR1yKTGm6B0tMVIe
        m25tALN2ccL1Q2nEFf24+Cg=
X-Google-Smtp-Source: ABdhPJwkKjfYHVQChlHALiGcV6f1DHW5B8GRXokMDMxNTibNUWSmL+CuPMWBl1J6gejsmFYSyM9BuA==
X-Received: by 2002:a17:902:b213:b029:db:3a3e:d8ad with SMTP id t19-20020a170902b213b02900db3a3ed8admr12964584plr.73.1610298350182;
        Sun, 10 Jan 2021 09:05:50 -0800 (PST)
Received: from localhost ([2601:647:5b00:1162:1ac0:17a6:4cc6:d1ef])
        by smtp.gmail.com with ESMTPSA id x23sm16424943pgk.14.2021.01.10.09.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jan 2021 09:05:49 -0800 (PST)
Date:   Sun, 10 Jan 2021 09:05:46 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     Tom Rix <trix@redhat.com>
Cc:     Moritz Fischer <mdf@kernel.org>, gregkh@linuxfoundation.org,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        linux-kernel@vger.kernel.org, moritzf@google.com,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Zheng Yongjun <zhengyongjun3@huawei.com>,
        Russ Weight <russell.h.weight@intel.com>,
        "Gerlach, Matthew" <matthew.gerlach@intel.com>,
        Sonal Santan <sonal.santan@xilinx.com>,
        Xu Yilun <yilun.xu@intel.com>,
        Richard Gong <richard.gong@intel.com>
Subject: Re: [PATCH 0/8] FPGA DFL Changes for 5.12
Message-ID: <X/sz6lDq8WFzrRUJ@archbook>
References: <20210107043714.991646-1-mdf@kernel.org>
 <80b29715-aa0a-b2ac-03af-904fc8f8be98@redhat.com>
 <e1d30642-ce85-b9b7-e8b2-5ad4fe6338e5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1d30642-ce85-b9b7-e8b2-5ad4fe6338e5@redhat.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Tom,

On Sun, Jan 10, 2021 at 07:46:29AM -0800, Tom Rix wrote:
> 
> On 1/7/21 8:09 AM, Tom Rix wrote:
> > On 1/6/21 8:37 PM, Moritz Fischer wrote:
> >> This is a resend of the previous (unfortunately late) patchset of
> >> changes for FPGA DFL.
> > Is there something I can do to help ?
> >
> > I am paid to look after linux-fpga, so i have plenty of time.
> >
> > Some ideas of what i am doing now privately i can do publicly.
> >
> > 1. keep linux-fpga sync-ed to greg's branch so linux-fpga is normally in a pullable state.

Is it not? It currently points to v5.11-rc1. If I start applying patches
that require the changes that went into Greg's branch I can merge.
> >
> > 2. an in-flight dev branch for the outstanding patches 
> 
> I have setup these branches based on Greg's char-misc-next
> 
> fpga-next, which is char-misc-next base for fpga-testing
> 
> fpga-testing, all the in-flight patches that would apply with automatic merge conflict resolution
> 
> These are respectively
> 
> https://github.com/trixirt/linux-fpga/tree/fpga-next
> 
> https://github.com/trixirt/linux-fpga/tree/fpga-testing

Feel free to have your own repos/branches etc, but I'd like to keep the
offical trees on kernel.org.

Tbh I'd much rather see the patchwork instance be cleaned up if you want
to do stuff.
> 
> 
> There are two trivial changes, that could go to 5.12 now.
> 
> fpga: dfl: fme: Constify static attribute_group structs
> 
> fpga: Use DEFINE_SPINLOCK() for spinlock
> 
> respectively
> 
> https://lore.kernel.org/linux-fpga/20210108235414.48017-1-rikard.falkeborn@gmail.com/
> 
> https://lore.kernel.org/linux-fpga/20201228135135.28788-1-zhengyongjun3@huawei.com/

I was going to pick them up monday ...
> 
> 
> There are a couple of patchsets that conflict
> 
> https://lore.kernel.org/linux-fpga/20210105230855.15019-7-russell.h.weight@intel.com/
> 
> https://lore.kernel.org/linux-fpga/20201203171548.1538178-3-matthew.gerlach@linux.intel.com/

Conflict between what and what?
 
> And the xilinx patchset
> 
> https://lore.kernel.org/linux-fpga/20201217075046.28553-1-sonals@xilinx.com/
> 
> Which is being split/worked on offline.

I'm not sure what that means.
> 
> 
> If I have missed any patchset, poke me.
> 
> Tom

- Moritz
