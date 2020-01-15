Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2563B13B8CF
	for <lists+linux-fpga@lfdr.de>; Wed, 15 Jan 2020 06:10:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728895AbgAOFKn (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 15 Jan 2020 00:10:43 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:36709 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbgAOFKn (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 15 Jan 2020 00:10:43 -0500
Received: by mail-pj1-f65.google.com with SMTP id n59so7145490pjb.1;
        Tue, 14 Jan 2020 21:10:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=x0sMapq9swaZtL82FLYfnbMqZ10mvQ1x7edYmjwiQss=;
        b=eBP6mwwAgcu+oMVKVIFyJ0jg/r8ZRafk50xCPKZmxbQNYx6TSiBIyYGjd9PvhbBp5t
         wP8B2BJtguTYg30y8lqHgDnRu+RhtTQL55JozzxGlgWCkiaukyiOWNRtPQBRZeLPru1/
         kuiYMyrpnAIOlQSbL+w/Z5aPc8QvVdfZJnGYxMzZABrFGoLoXpXbg80ACMBiHzmAZZkF
         OIJI1xRwSUhB7VQleR2g3VA4un8XBPEcT3WJjtKfJGfoFM7J+GVD0aIcQxDAQMYaaynN
         shv7MLLqMHjft3Czbl7BjVpF9l6i+ZO6l1b9/sMjTWbNZElEMLlPvH2Cr1tHx5rOwzjm
         bszg==
X-Gm-Message-State: APjAAAUPPsd0qbnPfsgXwvq9vDcCICyqzxBfjvpzqlZsCjqmHvU8G2Ig
        XkWEVQZmpQ2IfxTpgvaESmx3OTSm
X-Google-Smtp-Source: APXvYqxt1SeWNnk7qTNMgQIZA/pZ1v2rFLXYg0fUidOnZWCwgde1FjHIARePzC+AO0osv/JmHGQ+3g==
X-Received: by 2002:a17:902:547:: with SMTP id 65mr28728166plf.50.1579065042411;
        Tue, 14 Jan 2020 21:10:42 -0800 (PST)
Received: from localhost ([2601:647:5b00:710:ffa7:88dc:9c39:76d9])
        by smtp.gmail.com with ESMTPSA id c14sm18791959pjr.24.2020.01.14.21.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 21:10:41 -0800 (PST)
Date:   Tue, 14 Jan 2020 21:10:40 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     mdf@kernel.org, Will Deacon <will@kernel.org>,
        mark.rutland@arm.com, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        atull@kernel.org, gregkh@linuxfoundation.org, yilun.xu@intel.com
Subject: Re: [PATCH v6 0/2] add performance reporting support to FPGA DFL
 drivers
Message-ID: <20200115051040.GA1389@epycbox.lan>
References: <1573622695-25607-1-git-send-email-hao.wu@intel.com>
 <20191125033412.GB890@hao-dev>
 <20191125080127.GC1809@willie-the-truck>
 <20191125080839.GA6227@hao-dev>
 <20191209024527.GA22625@hao-dev>
 <20191216010104.GA32154@yilunxu-OptiPlex-7050>
 <20200106023742.GA3980@hao-dev>
 <20200114055605.GA13574@hao-dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200114055605.GA13574@hao-dev>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Greg,

On Tue, Jan 14, 2020 at 01:56:05PM +0800, Wu Hao wrote:
> On Mon, Jan 06, 2020 at 10:37:42AM +0800, Wu Hao wrote:
> > On Mon, Dec 16, 2019 at 09:01:04AM +0800, Xu Yilum wrote:
> > > On Mon, Dec 09, 2019 at 10:45:27AM +0800, Wu Hao wrote:
> > > > On Mon, Nov 25, 2019 at 04:08:39PM +0800, Wu Hao wrote:
> > > > > On Mon, Nov 25, 2019 at 08:01:28AM +0000, Will Deacon wrote:
> > > > > > On Mon, Nov 25, 2019 at 11:34:12AM +0800, Wu Hao wrote:
> > > > > > > Hi Will and Mark,
> > > > > > > 
> > > > > > > Could you please help us on review this patchset? as this patchset mainly 
> > > > > > > introduced a new perf driver following the similar way as drivers/perf/*.
> > > > > > 
> > > > > > Why is it not under drivers/perf/, then?
> > > > > 
> > > > > Hi Will
> > > > > 
> > > > > Thanks for the quick response. This is one sub feature for DFL based FPGAs,
> > > > > and we plan to put this sub feature together with others, including related
> > > > > documentation. It only registers a standard perf pmu for its userspace
> > > > > interfaces.
> > > > > 
> > > > > > 
> > > > > > > This patchset has been submitted for a long time but didn't receive any
> > > > > > > comment after v4. we appreciate any review comments! thanks in advance. :)
> > > > > > 
> > > > > > Hmm, not sure I saw the previous versions. Guessing I wasn't on cc?
> > > > > 
> > > > > We switched to perf API from v4, and started ccing you and Mark from v5. :)
> > > > 
> > > > Hi Will
> > > > 
> > > > Did you get a chance to look into this patchset?
> > > > 
> > > > Thanks
> > > > Hao
> > > 
> > > Hi Will
> > > 
> > > Did you have time to look into this patchset? We have done review work
> > > for FPGA part. And as a perf driver, we appreciate your comments.
> > > 
> > > Thanks
> > > Yilun
> > 
> > Hi Will
> > 
> > Did you get a chance to look into this patchset these days? 
> > 
> > Actually we didn't receive any comments for a long time, if you are busy and
> > don't have enough time on this, do you know if someone else could help with
> > review and ack from perf driver point of view, or any other things we can do
> > to speed up this? Thanks in advance! 
> 
> Hi Moritz
> 
> Looks like still no response from Will. :(
> 
> Do you know someone else could help?

Do you have some feedback? I'm a bit confused on what to do in such a
situation, do I just take the patch if the maintainer doesn't respond
for a while?

As always thanks for your help!

Cheers,
Moritz
