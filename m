Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA3020BAE9
	for <lists+linux-fpga@lfdr.de>; Fri, 26 Jun 2020 23:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbgFZVED (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 26 Jun 2020 17:04:03 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:34300 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbgFZVEC (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 26 Jun 2020 17:04:02 -0400
Received: by mail-pj1-f66.google.com with SMTP id cv18so1826171pjb.1
        for <linux-fpga@vger.kernel.org>; Fri, 26 Jun 2020 14:04:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+bNWshAB8GlnR/I8YTjo1AOzyrf/1ZMsaGOvqtkMIaY=;
        b=PW9cXP2WVRtYwI29E1I1hk0kvJpTygZG+HbU1TtROeyAJMVpOb7d5FjS/kIFKUqT+k
         oQlrnY8otsvjBbCebDZpGOvD9+24fLNubR7RpZTQEBB9l/lLkexwIjazHIJEkpAlGCFL
         hjR0x+XjMM9oFa+0Nwg/Za+dMHrkwGqL1y76YyZuWVILauRvwy0R9erxLKaCT8TmOwdp
         llUlTHcio76IuvwUJQgZxI6r9lGM4kIwH7AZdldpGJyqmJVPuBAokq5I59NMPH8kKGDF
         ZOQBXqC0KHPyyGEY4NXdXqIG0n5/iVgteTxMH2vlE5Hl2dOxIafYo/9vH7hafJtShKPb
         6onQ==
X-Gm-Message-State: AOAM530vubz3Lks/eV6fTcwOkhf2XN//QYOX/6YDZOD9zqT+SaLIYaJK
        pddt8BImEGhakX+V9chiztc=
X-Google-Smtp-Source: ABdhPJy0aiVo/3IZsljOt6PEMpnh+VwHON5fPSL1nPfyiwbTj4BD9e554B1KGc5vpP2kdkgRT4r+PA==
X-Received: by 2002:a17:902:9a45:: with SMTP id x5mr4174369plv.190.1593205441749;
        Fri, 26 Jun 2020 14:04:01 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id z7sm13190469pjb.26.2020.06.26.14.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 14:04:00 -0700 (PDT)
Date:   Fri, 26 Jun 2020 14:04:00 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        moritzf@google.com
Subject: Re: [GIT PULL] FPGA Manager (late) fixes for 5.8
Message-ID: <20200626210400.GC2259@epycbox.lan>
References: <20200609154800.GA16679@epycbox.lan>
 <20200626152759.GA1425473@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626152759.GA1425473@kroah.com>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, Jun 26, 2020 at 05:27:59PM +0200, Greg KH wrote:
> On Tue, Jun 09, 2020 at 08:48:00AM -0700, Moritz Fischer wrote:
> > The following changes since commit 3d77e6a8804abcc0504c904bd6e5cdf3a5cf8162:
> > 
> >   Linux 5.7 (2020-05-31 16:49:15 -0700)
> > 
> > are available in the Git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git tags/fpga-fixes-for-5.8
> 
> I just realized that linux-fpga is not on lore.kernel.org, any reason
> why not?  That meant I couldn't use 'b4' on this :(

Who do I talk to for enabling this? Konstantin?
> 
> Anyway, now pulled and pushed out, thanks.
> 
> greg k-h

Cheers,
Moritz
