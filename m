Return-Path: <linux-fpga+bounces-432-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1198A0719
	for <lists+linux-fpga@lfdr.de>; Thu, 11 Apr 2024 06:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A04781C21819
	for <lists+linux-fpga@lfdr.de>; Thu, 11 Apr 2024 04:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B83D13B78E;
	Thu, 11 Apr 2024 04:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXaGyU1j"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF075EAC2
	for <linux-fpga@vger.kernel.org>; Thu, 11 Apr 2024 04:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712809557; cv=none; b=fXOabuY72PXSpOfcAyInVRFk98LETQZT5G23UNKys5pKDiSTj4+qwI3zWioKVVO76ZelWyB0ODZOxzCfYLY8rvt6++UjmrCONB/iDnxjyQtjiXoDvqQ3/tZVztNCPGm5nxHY3CpgmvK3NNSvN0VvUDYpCkNRLm4iAR78cB2qKPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712809557; c=relaxed/simple;
	bh=hwjG3iJP6XbvlRA0RJyMvNjjpXWiysGR2e/PBTL8IJ8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=XDfhC/exHPuNqvQfn8qWy8wU/R0bN3INEcLHXkk+iyETfQKl+Sqq51nAMHhPTWXXmctoTNyLJpSCdpFiYsoGRK/5gcxZOp+Z1tVjeEvbbunK+i4JlD7pse2ERJkxF4RN6yUcih4O27hicocdSvwXevrH9Ia8oOvbO5EOnIAsfGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mXaGyU1j; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-229661f57cbso3831314fac.1
        for <linux-fpga@vger.kernel.org>; Wed, 10 Apr 2024 21:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712809555; x=1713414355; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZkcQo1LIJphzWK//pyWo3zL06J6COhPfHEN/Z6S7eE8=;
        b=mXaGyU1jnse2YRrQ2KYigEikVR8cV351TDsdOBNScz/X+Wq4+Uu7X/4iHItZ0pQRiE
         vSo8wk5JN04mxznFv5/G9gvOvpO4ajd7vc5Dq6Wi7oeeKD1erUEmmGpz9TfLiMF8WB9O
         DtYL+gj0fKzwptXKegcsRdGXwlfrB7J4vZrH2fTdIjJHzZgoP3eUJthkHnP2o96U3W3h
         1ROKBI2x35VuK/poOq6UCFt2RuxHyvq5Sj9cboJW3/cvlFq4LvzNdp6Ez6OfsN5wJV8c
         4bw5i+Aopv8EHcLqwtJdb5RuNbt5b5+QBG6/xPE/VPbZJY2/bdUVaNhb08TRCagGrh9a
         47Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712809555; x=1713414355;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZkcQo1LIJphzWK//pyWo3zL06J6COhPfHEN/Z6S7eE8=;
        b=lk6WPHrg1WLgKjP7K9xGASJV3h7fkp6RV217P0t2KN0SXa0Pwg97QsCW8qFJzNXxaa
         hRi9s3qAx4PwnyWhqDQRp5XM6sEsq1T5Qtcw1/lHRlrhG05fySrk1JHV1vLa9RIgUEyE
         ok9M3g4yQk6FLtIPei6r44Jt7xQ2ahQTSfvrAlTPhJWwXdpDybw0XLA0vu6FFJEHOhPR
         OFjfCMGXVIVYFplKMrXyhFxYmuegSu39xrmU6PM4CTvBt1QmPasPwZzkMP9HXpVP7pLP
         an93yscE2X+8NysZyViyYJBODVgiGCCtEcnaV5xTFOmiw1iDtWst16uK/lYrSpIU0IkO
         GRIg==
X-Gm-Message-State: AOJu0YwpP0BhgzyhkarVIGkU4MyjozDhd+J57MZJPEBDxgfnkBosOUIW
	AgXf3/pEw+mWmnJ8i4+xslAKEpRR0KlPPOQoqzqanzv3Abwg9l+TNCka6u1duUZtk1ILIyL3JAs
	tjuwiftBYv6pPQ5uOvfIlKWBquIfBqK+1
X-Google-Smtp-Source: AGHT+IHw26lOWkBRUFPIFM2ZL6ynm/aiIysP1/sGobxko7tTHSnQ6oWQVJL3Q94bBtfWfhaMm/1eIKCb9KV7lMf2Tg4=
X-Received: by 2002:a05:6871:5889:b0:22e:c4e7:8aba with SMTP id
 ok9-20020a056871588900b0022ec4e78abamr5098017oac.47.1712809554563; Wed, 10
 Apr 2024 21:25:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: David Gideon <gideonda32@gmail.com>
Date: Thu, 11 Apr 2024 14:16:24 +1000
Message-ID: <CAOLMD=xWnfEVEobNnE+ipMwi=x7wNA7ZfQo1+9CH8UyUVAffQA@mail.gmail.com>
Subject: info->header_size always 0, breaks fpga-zynq.c driver
To: linux-fpga@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Everyone,

Our Xilinx FPGA driver (zynq-fpga.c) is no longer compatible with
fpga-mgr.c and barfs with:

      "Invalid bitstream, could not find a sync word. Bitstream must
be a byte swapped .bin file"

It seems to come from here (inside fpga_mgr_write_init_buf()):
      size_t header_size = info->header_size;

It uses header_size to decide whether or not to call
fpga_mgr_write_init() with a NULL buffer and a 0 size, or use a real
buffer and real size, like this:

    if (header_size > count)
        ret = -EINVAL;
    else if (!header_size)
        ret = fpga_mgr_write_init(mgr, info, NULL, 0);
    else
        ret = fpga_mgr_write_init(mgr, info, buf, count);

The trouble is, that if I follow my code path, info->header_size isn't
set by anyone.  So it's **ALWAYS** zero.  But the value **should** be
128:

    static const struct fpga_manager_ops zynq_fpga_ops = {
         .initial_header_size = 128,
        ...
    };

The issue seems to have been introduced as part of commit 3cc624beba
which I have linked to here:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/fpga/fpga-mgr.c?id=3cc624beba6310a8a534fb00841f22445a200d54


What I find really interesting is that the original mailing list patch
submission didn't have this bug, and would have worked for us:

    + if (info->header_size)
        + header_size = info->header_size;
    + else
        + header_size = mgr->mops->initial_header_size;

Could this be a viable way to ensure that the FPGA manager driver is
compatible with the zynq-fpga.c driver again?


- DG

