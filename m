Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3931A2A497B
	for <lists+linux-fpga@lfdr.de>; Tue,  3 Nov 2020 16:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbgKCPYe (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 3 Nov 2020 10:24:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728299AbgKCPY3 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 3 Nov 2020 10:24:29 -0500
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A1BC061A47
        for <linux-fpga@vger.kernel.org>; Tue,  3 Nov 2020 07:24:27 -0800 (PST)
Received: by mail-oo1-xc2c.google.com with SMTP id n2so4286788ooo.8
        for <linux-fpga@vger.kernel.org>; Tue, 03 Nov 2020 07:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=N71Zs4qg4W+XUXzJvJITvEfPb9AWspIlQairrp1whfg=;
        b=rrVlj56yk2trpBYSpi4k2yd1xCK2bo7zfyPwMRTDKgj2zJFZf+rsg3l64hS6mNlXsJ
         /lsnCjsBYlscUhZQjxreix9yr1FDyyJ44isM98ku6PfR5nfH8ewfPGTyJoG+z8DaKf3B
         GC0lFyYci0jWLRuivuAjfzCGQfauYD+FIBoJ65Z0ysgZFvM7r9APNUcj/A/ERVF2MbLf
         yty4WBGjCP2WpSIZHr96/NF2lvOu9gyd0kH5dNJE6T16tbnf8/wDcP2ZEnVaZTeW+uv8
         AOywb/DHyLh7Si/JMqeCh4eS5XqaKQQMWQhjlysMgge2i4X83N4I6vLqLPfg4x7OeC6p
         Yirg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=N71Zs4qg4W+XUXzJvJITvEfPb9AWspIlQairrp1whfg=;
        b=Cy0YUB+tP0Y3SbpdaAnmZiJU4d1ZpVoEr7mILPp4biIGEiF1ElOv8NTQRrFsUe63hM
         XVyAZtlfqsRqWhhq+kyYkvsRv9B9kV+HQMi+DT5LcQu7sSfcmgamOlj+a8pJlDe8cnG4
         vPMvwScDSOfiEfU0XGhkgPKV0z4TNnLrKO8qlNY+tRmwcj9Gggkgx4l51OqES8s56PH+
         WmiAP2HykYgjGoebsCU5GH0fpQ4wPxQb0y4wg1RLAE70EUojz8PHx1NERXbyWF4Duofn
         nGsNtRMPZexaK/diaUBL2a335F3EguH+AkZJBrATfUFEil2DLHPYxVey4baH+V5Fyij6
         HHPQ==
X-Gm-Message-State: AOAM5319j3xLW+7UopBrRRWDIlEPrXNl8+BJLhZmFpAiEsbIXLgc9lhT
        HHBrcNdLKEtY4Xp0SKcOJdEMuQ==
X-Google-Smtp-Source: ABdhPJwU2NP+qjv7T5X33Bc5Qb64pjBRUiEN1Yk0nWz/TQ1GhwOuIu9xrFu+5vjm7/EyqQJ1LvpBNw==
X-Received: by 2002:a4a:6b1a:: with SMTP id g26mr10661391ooc.13.1604417066733;
        Tue, 03 Nov 2020 07:24:26 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id v5sm4548511otb.44.2020.11.03.07.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 07:24:25 -0800 (PST)
Date:   Tue, 3 Nov 2020 09:24:23 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        coresight@lists.linaro.org, dri-devel@lists.freedesktop.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-fpga@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-i3c@lists.infradead.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org
Subject: Re: [PATCH 30/33] docs: ABI: cleanup several ABI documents
Message-ID: <20201103004241.GD223412@builder.lan>
References: <cover.1603893146.git.mchehab+huawei@kernel.org>
 <95ef2cf3a58f4e50f17d9e58e0d9440ad14d0427.1603893146.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95ef2cf3a58f4e50f17d9e58e0d9440ad14d0427.1603893146.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed 28 Oct 09:23 CDT 2020, Mauro Carvalho Chehab wrote:
[..]
>  .../ABI/testing/sysfs-class-remoteproc        |  14 +-

for this:

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Thanks,
Bjorn
