Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72022198980
	for <lists+linux-fpga@lfdr.de>; Tue, 31 Mar 2020 03:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729035AbgCaB2Z (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 30 Mar 2020 21:28:25 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:35370 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729021AbgCaB2Y (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 30 Mar 2020 21:28:24 -0400
Received: by mail-pj1-f65.google.com with SMTP id g9so394691pjp.0
        for <linux-fpga@vger.kernel.org>; Mon, 30 Mar 2020 18:28:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LY9bxSffzPd8gQCgVDZGa1hALMmycm90yOC6o7gPsRY=;
        b=QJD+tv2J04j1dIe2Kk9qitbNN/Uk2Jt+U71sytcmEwVCIH6AHw/vQWLt2ynQ5Rs2J7
         OBSVz6hZ5PYjPeWgzrbMf6INK1VjOUCbW2ioiOD28v1Zop6XPlp6Hg0hni85AEs71OlP
         9Ln901/VtFkTl7ywxyk3xFsDYm37YkmXu6sT2PPTCneapqsEZZUidAlyjvpWvOWvMfR1
         BXi+oQ05hN00HT/UTOmQyIPvrhAhKD72xj9fySg5Bq9n4AHdYiWJx0nfCgIyTBLQn9di
         d0GaICrgyzQMPpt/RU/+hmSt5Bua4kepvp8mWe9YbZxnh5VdBARqzFFquC2Q6RQ4SFb9
         i+sw==
X-Gm-Message-State: AGi0PuZ9QmDY5SmHnMtYY/DHXsXyzDqM2I5E6ON/UF+nHNpfhBnIbSyU
        eN93jmbdrbpyOvintsPcptg=
X-Google-Smtp-Source: APiQypKEEddLSsLfbjq7qz0AN/cIbxhS9olre5TVFktjTICk8vD7hzZLpVoiOwV8Rq8uR8A5d9vyTQ==
X-Received: by 2002:a17:90a:a889:: with SMTP id h9mr1034768pjq.40.1585618102129;
        Mon, 30 Mar 2020 18:28:22 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1160:3ae1:1f56:6f77:5f9e])
        by smtp.gmail.com with ESMTPSA id e8sm626143pjt.26.2020.03.30.18.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 18:28:21 -0700 (PDT)
Date:   Mon, 30 Mar 2020 18:28:20 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Moritz Fischer <mdf@kernel.org>, moritzf@google.com,
        linux-fpga@vger.kernel.org
Subject: Re: [GIT PULL] FPGA Manager changes for 5.7
Message-ID: <20200331012820.GA1492@epycbox.lan>
References: <20200327162944.GA4118@epycbox.lan>
 <20200330141506.GA438143@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330141506.GA438143@kroah.com>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Mar 30, 2020 at 04:15:06PM +0200, Greg KH wrote:
> On Fri, Mar 27, 2020 at 09:29:44AM -0700, Moritz Fischer wrote:
> > The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:
> > 
> >   Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)
> > 
> > are available in the Git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git/ tags/fpga-for-5.7
> > 
> > for you to fetch changes up to 3d5a5417ad064a6ca64a33f0c554d917311c79f4:
> > 
> >   fpga: dfl: afu: support debug access to memory-mapped afu regions (2020-03-21 13:14:30 -0700)
> 
> This is too late for 5.7-rc1 as stuff needed to be in my tree last week
> (and not Friday), to give it time to test in linux-next.

Yeah, I realized I'm a bit late ... I figured since they've been already in
linux-next it might be ok. Sorry about that :)
> 
> Care to break this up into two trees, stuff for 5.7-final with bugfixes,
> and stuff for 5.8-rc1?

Sure, will do.

Cheers,
Moritz

