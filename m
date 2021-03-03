Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C983132C88A
	for <lists+linux-fpga@lfdr.de>; Thu,  4 Mar 2021 02:15:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240909AbhCDAvF (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 3 Mar 2021 19:51:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353155AbhCDAD2 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 3 Mar 2021 19:03:28 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65DCBC061763;
        Wed,  3 Mar 2021 15:15:10 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id u12so5391490pjr.2;
        Wed, 03 Mar 2021 15:15:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mt8/q9przhRO9oiYAln8itOH0lx/lQPxaj7HDM76lXE=;
        b=LVW0ontmptCBzchxvOuz4WAsECT3TwOjZ2yv/RDcPBLknSUvgoScXw+uhmeU4a0dW4
         AGt8S0pBoCUOzLRIsOCPK6BwpdyEJr+tltC6NvpaLJ1hlwgE3QjC1mrJ8zAikE3Jyctl
         y7eNjDu3yevSSHbXLGQ4cX/gx442DnAYKMFuowa3JzAj4v87IvYrX1iUjrDpu6njDyV/
         4us56OOkaSw/2c3wuwQPZUXSOnTEFst/5No4aWrhQP00Gqbh20pzMTUOn+AAqWaSxGLD
         Z1XK9DT4SpqkCC3O2xj70KBu5/7CSa8VxfbfQg7pwWFt6Zk6M4paONa3HdlNNuNW6NZD
         SFeg==
X-Gm-Message-State: AOAM5338z6Fo2GMk+Bl8W2fS7v/x7R5lAKJXDr8plSdjvq2cf5Glw43K
        7UiSbFKekIRgh+SConJwp++AJrth0EY=
X-Google-Smtp-Source: ABdhPJwVAU51jdeE3BpJvU5lPgtNpJaSi+tPloqGIpFcULsqq3+Z8+wzo1XXQYiPE/nlEnsyf177gw==
X-Received: by 2002:a17:90a:4a81:: with SMTP id f1mr1391947pjh.44.1614813310297;
        Wed, 03 Mar 2021 15:15:10 -0800 (PST)
Received: from localhost ([2601:647:5b00:1162:1ac0:17a6:4cc6:d1ef])
        by smtp.gmail.com with ESMTPSA id 188sm25463092pfz.119.2021.03.03.15.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 15:15:09 -0800 (PST)
Date:   Wed, 3 Mar 2021 15:15:10 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     Moritz Fischer <mdf@kernel.org>, Lizhi Hou <lizhi.hou@xilinx.com>,
        linux-kernel@vger.kernel.org, Lizhi Hou <lizhih@xilinx.com>,
        linux-fpga@vger.kernel.org, maxz@xilinx.com,
        sonal.santan@xilinx.com, michal.simek@xilinx.com,
        stefanos@xilinx.com, devicetree@vger.kernel.org, trix@redhat.com,
        robh@kernel.org
Subject: Re: [PATCH V3 XRT Alveo 00/18] XRT Alveo driver overview
Message-ID: <YEAYfvJk+iyi+G+6@archbook>
References: <20210218064019.29189-1-lizhih@xilinx.com>
 <YDLF2Bi3oEhP6A7Q@archbook>
 <70f35c99165ac4dd1846ea2e30b9a1745c364903.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70f35c99165ac4dd1846ea2e30b9a1745c364903.camel@perches.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Mar 02, 2021 at 10:49:43PM -0800, Joe Perches wrote:
> On Sun, 2021-02-21 at 12:43 -0800, Moritz Fischer wrote:
> > On Wed, Feb 17, 2021 at 10:40:01PM -0800, Lizhi Hou wrote:
> > > This is V3 of patch series which adds management physical function driver for Xilinx
> > > Alveo PCIe accelerator cards, https://www.xilinx.com/products/boards-and-kits/alveo.html
> > > This driver is part of Xilinx Runtime (XRT) open source stack.
> []
> > Please fix the indents all across this patchset. Doesn't checkpatch with
> > --strict complain about this?
> 
> I glanced at a couple bits of these patches and didn't
> notice any of what I consider poor indentation style.
> 
> What indent is wrong here?

Maybe I dreamed it, or confused it with the CamelCase issues instead?

Sorry for the noise in that case,

- Moritz
