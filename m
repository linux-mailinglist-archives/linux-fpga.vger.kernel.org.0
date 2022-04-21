Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14A2150A38B
	for <lists+linux-fpga@lfdr.de>; Thu, 21 Apr 2022 17:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389769AbiDUPAr (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 21 Apr 2022 11:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389759AbiDUPAo (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 21 Apr 2022 11:00:44 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD9C443F1
        for <linux-fpga@vger.kernel.org>; Thu, 21 Apr 2022 07:57:54 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d14so3407127qtw.5
        for <linux-fpga@vger.kernel.org>; Thu, 21 Apr 2022 07:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FfZNCizm0Kgf1lEBR0XR9Meqi5ihWzie8fY0lQAxquc=;
        b=l53Qzlyz/ITKu/ZFDMfzyBNJJv+J5kWUdOVNjodIZ/lJ0jABu9mD9+3IY/kc3RU+cs
         CtQvbjrqDW7GqA6xNvWD6eHjfjhGGoG8mqWuZ518j5IJ9q4eZldSVlezfJp6/45tJRnV
         9v/w4Hbh/xbgFbBlvT9duNCVFpNxWWaCzthk/cRR3fQWVlhKj3oF0hxz6+HVD7vWEp2m
         cFc614cP530AbYm6vIN+25crdBydtdNN2mRa7u7A3G64sUwpDCu06eAuSazKJV3pta9W
         D4RsmTrwYd6sb4TC8rEpRDQxNzU3G5GLqzJyUlgbQJCsxfZEj/AupFrdeJtNKk5sryVp
         Swmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FfZNCizm0Kgf1lEBR0XR9Meqi5ihWzie8fY0lQAxquc=;
        b=ZcCyH7DF0uHgPVzJayM/UEFSO5MxTTBdNl3/dDlCoauMH99eMuavJYgmZPquD4xUYS
         02ypue4oNyJcccnHnvzA8LC1esFWVDyc09vAG/suWa/sWxYGYn+TiIR/owSMcWQuLqEj
         gtAPSPBlXrQPdsvuBr1kQYF/71RXLmW4DusP1bkB1ewA9NADnK4BjglQvIc0lXpRT7y/
         jfYXW83ORzj+ewOwUGmPidB75cLJEq4E3wB9uCgRXhNnIS89skzNJMy64FaIz5apg954
         eqHqH4WekpD8t490doIKYCZjZDsqV/pIs7Zf1Ydhm2QDnbp4x0EW0VcXmvjrcT4LsaNy
         6nyw==
X-Gm-Message-State: AOAM531dI+FxRAlYfuCfwRbkkyJSEINkf79vW71hrEeCWezOZusfCTdQ
        j/P+O57oGp5bwO4qDIuh6CJ3z8pgQwPSQQ==
X-Google-Smtp-Source: ABdhPJzOJcz57QkK9Ar8/hS2OYw2gKk4ceEYG2hUEPSmcuqXnBZayTqmhBBVgFqnIpUUkz4eMglw0Q==
X-Received: by 2002:a05:622a:1186:b0:2f2:68:898 with SMTP id m6-20020a05622a118600b002f200680898mr13169130qtk.389.1650553073296;
        Thu, 21 Apr 2022 07:57:53 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id a7-20020a05622a064700b002e238d6db02sm3825225qtb.54.2022.04.21.07.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 07:57:52 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nhYFk-007DbO-7X; Thu, 21 Apr 2022 11:57:52 -0300
Date:   Thu, 21 Apr 2022 11:57:52 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     linux-fpga@vger.kernel.org, yilun.xu@intel.com, hao.wu@intel.com
Subject: Re: [PATCH] fpga: fpga-mgr: Fix undefined behavior
Message-ID: <20220421145752.GU64706@ziepe.ca>
References: <20220421143924.68443-1-mdf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421143924.68443-1-mdf@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, Apr 21, 2022 at 07:39:24AM -0700, Moritz Fischer wrote:
> Incrementing void pointers is undefined behavior.

AFIACR in the kernel dialect of C this is defined behavior..

Jason
