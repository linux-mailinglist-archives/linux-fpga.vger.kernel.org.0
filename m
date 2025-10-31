Return-Path: <linux-fpga+bounces-1398-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1066C26875
	for <lists+linux-fpga@lfdr.de>; Fri, 31 Oct 2025 19:10:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16A783B9BDF
	for <lists+linux-fpga@lfdr.de>; Fri, 31 Oct 2025 18:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586C73502AA;
	Fri, 31 Oct 2025 18:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="ngUDwiD3"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4637C2FE593;
	Fri, 31 Oct 2025 18:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761934195; cv=none; b=RMwEsBThcjEHHN1e4TKI0Z5p8CKoSuIeZzhr/xAjq3yNdS5lU5x3dFkHENU7LGzVurNXMgG8+ANEhwMnQdz8n6MwPVDSaas90EBYWpoH/3JXEUTAwmmzTu5fmfcMjHvOwPB0TIFGsx/UHJh+WZbKXxlcY77IU31Grh1IkgXcySA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761934195; c=relaxed/simple;
	bh=X/T7VlrmfUiETjz48xqNtteS+0WZkcyXhboH0dEXXBk=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=svTx0u0YGdf6Fk2zeevLsSfFIwGtiEp4ClZ0WjNqF6NnJm1Q980BfB9BB1HuAx5FwwaS+K5LZVreCmRMAk1s6+QFaK606zcHdTWs2ztMlbcZ3vephyS4yLi1SSHL6d/EykyYs3Z2zrCL6+xD/FL8C5lEKjUIi99Fd+Pwg7h8flY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=ngUDwiD3; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1761934190; x=1762538990; i=markus.elfring@web.de;
	bh=zLLGdw6y9rxoGlcn52s8qTx9QBXWfNxJq1UtVJsoiNQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ngUDwiD3a6/xx2psZ4rBKVbHU1Ki1CIPJDPH7I4kQmUIVEn6b3XrAVeMCKEytPuu
	 TQRqmjcslvaKz2iv8Ti6YUZGEqcnpUUFD0CARhg83UlFCdQmSMMtKgdAggomdVhBy
	 nfEKnq4nFDuSXE07XLmG7xyDkpkzVK0RDsuFtnlhqbfd+JJ+CHSwk7+e+3Bebb2RJ
	 QvJvSwQF3aa6lIaF6Jbd35lgBJJ5UDbP5Hy6zE8o1TTJDZUP+YOgxCC68YfBrL8R/
	 5QSyvv7Q8tjQjjb+fUPGh48JZyC7RFImHhErMcdB3JfLJyuzTXOjkKNJdj8Sq/XbE
	 Yz9U+JNATNe8F24P9g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.206]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MSqTE-1vgpjk09ss-00KcGx; Fri, 31
 Oct 2025 19:09:50 +0100
Message-ID: <836861fb-c9fd-4bb4-86c0-9d39d29f6bab@web.de>
Date: Fri, 31 Oct 2025 19:09:48 +0100
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-fpga@vger.kernel.org, Alan Tull <atull@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Moritz Fischer <mdf@kernel.org>, Richard Gong <richard.gong@intel.com>,
 Tom Rix <trix@redhat.com>, Xu Yilun <yilun.xu@intel.com>
Content-Language: en-GB, de-DE
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Miaoqian Lin <linmq006@gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] fpga: stratix10-soc: Use pointer from memcpy() call for
 assignment in s10_send_buf()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:szpmJIbNBkJQld1Z6+5NznEAogcD4CX1azLjcwRxJqVQIEYkTgc
 gFGqTzRxSDjK9KUbfwv+kCw1pT2WtRM4HxOL2UrVwiC9xnl/V6sP0dC33NsjAjnSNL+dwQJ
 AEEeOqX5InhNYYt5bd1msOJcHnqKvLsr0r7WuDgQ1lGI25QfBQUvvlTPklkNFkM9Rewms8O
 gTq4SiEYHLd3h3QdFgVug==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:QWFeVmZIzXs=;M5npvOdFQHaBnYA4RNKBW4cy/iQ
 gorL0YAjXJ7WQ0uNuvK/6AEPg8P3P3wJk78IPUElNSuR3YxmLrMSLGzrPnCFry9kAmdMfXwQr
 wcg3xTt26TQm9qGSqL4nRb7nZdjH5gXUhYcqZCHRGa7+2MxdAZvktMi/mtB7JNXZ8rqrVCcdo
 qU7bknql13Y0fmid2/9JhhivfQqPok8ICnvXy+NsBioR+Vjerg+tdvQIC9x5W6glZcWRiIRCm
 x+ZvPSozgbtfNgio1TD2r9HagZ58t+r0FAOqNdgPgsjl3DSaWSrnI+9CJAd+Ye88li55LTEze
 rnm1ZMkTALKtqQZuhOmzvWYwz1on7ULCEDYjqfYRZCRJLRXom+79y4xH1zP2KVQ+bB5zR3d0t
 3hYk97bfqHJF2T3ypnmOStVaa7Zkd2xA1j06a1FRGkdVwJTkCGOafjexy1Kj2iI8PDeCOSrkN
 D5YtMdPc/QuR+ln0N09m2YmdnsrVRYTF5ElXO6ITVXXK/T7IGqydXJaJJ+hHz6i3wClJCwTvf
 VQRPNnjOwAvMtbRRHyR+fm8C6ZjrPCiB9Jce4saxyX9Tw5qnFL9mcObKARqFjdxEjG2ZGa8WA
 XdMfL0rcBGLSJObCs8pua7q+VHHKFTosTrEY/oIYJ98BMeIeTOB5+gCYleaoFQhtTScTkVcWJ
 BtIwm8nsQcylD6TbwzmtXoIjQjik71M4Pi6sZ8YVVrAFOGih1Q6p8vlfGCanZl+qihTv34N5k
 cveWOMW6HiZWI68aZQc0sc+2/KPch9FjXnTZAYjkDboubN6R3MisqmubJjul1T+DRSVyTwvry
 4OSzixahDQRxzINVii/6TVTmT6Na0V+pX88U0BlGVqIYTuwqP2/K1BjOSnMkaR2coF/NeN2+5
 SzWI5UQx2GlEZv9+aqe0E0FcTEsVb0vhFNagH77zkUNqhN3oV/ZCDVq3Bi+BqRrYTP53f+TfJ
 kwASo6XLgAlDydoKnJ0kLvqgcAGt+vsNNzwjVeaIvDrjB9twqFH7XwuYpgYgJD+VdKWRC9N8o
 k0HCuJOBNNgOhtt1l9ddiiaia8GX9Jn2LATwrpaSz3nMTtAc5CdkIeP+38AtPE+o9XrCcadow
 ywn5AfdFXIbMEeGR1VM2EU6Z6EsS21IRzqB3YgoOJZltys07mWvrMMfIPeEdF/MZhchlVQAne
 5C3Cr+DSOJkow7zzzdGH5ull7B/qSuGJO5bEQj/dt9GFPjVVCUhUH2F/Ahr374MKfuueYljky
 wYs0CIO/zuy1RC0ptauo0aEa1CKj+hTRKSEgEIAcRwwBQO1IOJlvd4ibF65CZabvdKTpmd0VB
 E3Md2bHqsW+9uEgoL5jsJXp16btioZmyhUejMhsIPjRn9dTHu0w18EdlbKB9nMRc+l9Y1RPRr
 IGvIp3bWVy/i5e/slil/w90mS+bm+z0ijfYD+TFS8lmaYbM0y4rVfhX+fX5kl8sZtIYJsQj9U
 9t6FSRWejiwfeItJ3BbpAUV91ihnaP8nzb2YyjVpqsaS1LxlqTs5NpfMxBC6BJ+S44/vBb/hj
 WPxsVZcjJ+uHqABwHtDtgUW9EANaWFg60hoWhSvBpD4gYG2S5SvGTGW3B5g4qWQ/uKcMuOicb
 r1vpfs5+pu3uzvNf78ZnATYmnmabHsYZNxi5qOfpzHxQ4xRplVJgtKjUf0UwBgJwbsgNMexTz
 RBZqkNMjkW3sxJpUjdDp6PyIK0I9axNe3l+3BfsHJLGyqx7f13i7VdNBr70iiUSEWp78K8rV9
 0+AdqLS73d7eDUGoVFTLje2dBhjao0cTssF9FAM2bf/DHvwJA1s85jXxvxCvNxhXEKgNwDuzo
 nGIsmlCjOPoQorYDIyK9UDxnhIlSbBm/x/HoY0gTk1tes9zLovpAMtoCiHxsfTPU9MnWbRpl1
 s91VU5TbFV5eo4nzVYm8mdG+VwYcxks4avfgObCA3t2oVoyXLwZVndPAUUuaQYQRrLD8C/G0h
 /HH7jcenmJAJdqbT26iQO+jVTHV2QXBHNGuU7f15swS5JuueraZgg+uNCgIQ011oRgvxqRg1C
 qxyX9COKXRaAKalxDlFwygiSac7NeSNR8Svj9CvaKe6qaC5ZHHavyRPhiXDBKeYde/3+kdPRd
 fLFaWugFG8EocauW2870DjlYqeiMirajp1HWnqS15CGM4w0p2IGFcDkoDS4DPkkiTOMc92Se1
 gIq+WHKZ3W7rt95f4CoMuCzfJ7jrgNAwI0uxOkNATXUCLl7jTBbwQNcPBRo8KzOtrL/3YBoOH
 eurts2wFB0raPkO7m1dYSmDHJIvsgP8UYa9c0LMVOXPCLa4VWLQTv/CcFPWIZE86dK+9DdtDo
 CTzLPMVBdu+atlQ9Nw/IqZAxdvwQZd22ZG4WDWArcWc5DnmopAPFU4guN5YyC9h4tdrvi9zci
 iJ9I3ltYXodOIwR1cqWc5kxbGpDvs0cgzCdZQsiBJa7k79wIL7V2QtVTfOg37aYHNp0qkoCUV
 ZhR9LoKC9AvAxIxXQfkAF3m/11sazOE3liA474fcivrwI15BAHoCp7c/y5kb6SL3dJRrme3RK
 jgoux5lmF76Z8LkdnwG4tXsmHu2cAdPVIUMn7czpwH+efJXy5uikbvzpmmPoUt342YyCJedpL
 xtkCdfn7XJ/d2Qi79gSHfnJaLvp2MvKSZG/p7RIQzWtuagUkcaUU8OIL60FhQ0+jC7MSy5krf
 SF+4v6oimIpQoX2fU8Cs5SMo32Y3LujW/YGmefDBT/OhiOUrv94BE9fBhh18gH1nk9fodvIK+
 /LfaLduPhlLVO52uRO2IuT7uA2Ur4j9n8hkZxFagcXNcaJbhUaqvnD7iWNdkdt4nvGc6lSIw+
 SXflOwC/IZjMTO5xwMJEmp9+jq79hOFhaTTX0T+FLLMhwmsj1ep9rFRJvt1QaHo9hcd5Wopvi
 MbTOTJZeJ0Weo/QcL0FzmxYfae5vgJqFJc7qYXW0sW0Xojy0/gksrBXgbgB5vU+PBwN5GV+gP
 VaGDT3Y3+C/yjRzKJW5ezdeqlXTfmAfz0QrysTE6cYm4wQ9cyHUS3v5gSjcqESm/tqISiQYsm
 nQWp0I1YCgIVEuH6fPKSADTHXdapTIe+vVn+gWkesg/adDsk2sX+vTDU1uvNmKs5p/9nraRh8
 EQeFCdX/COck5g2ixqfebHq3QwmcA76Zr1QrLO5g+2NEnkWLS9OuqZCz3Iw61ZX2+Uwstt7n4
 HGV3GtBBOdSfU8xSfVHNo7bvAtBpVLJz+tx3PQKYirW81yD4hLXGPJiDho/8QK/5UwCZL7rns
 P7iv1kltk31p7VQKeGr1b86bKidglyfJ7tJVbQuUxK1sI/EA39wodD5xpcxxNdq7fkW9grVmI
 0ISR752Sv7GJDYaWwAfPdnyX7v9nKqor7r+PyVVI5mpXlcXSHj79r1Aj7kqUPfGFhCxBktU65
 RfzaNrAq6hh/tpavBAMTExCPMW96p1aoBI4H2SUqhmZH2yiUxK70j/HJWgLzENtddw93t2uE7
 25vt4jFFrOAptugHbDHB5SoBzXRhiP/OgfPz9L6CR30+5ZmAjuZJoU3alADWJuhbVVRguTrSI
 bQkB+Cb9aMbOR7Nn88QsJ2dJTCRbhUnzC7A2nMKCrjVQYWIBAf/aD9fDsBf+gzrvhZeW5ij0a
 1HST6OfT5y/uHYifnZLmwpSFo34qE7SC8x0VhQooU3Jz3ESiTosK8qftIyvTxAxDDu/pyOsbn
 Ohbn6bRXOU5J8OvzReoh3FG9mb7j6uI6bWgZdppgAZ+v51ErIyW0jz8KPgm9rl+yPZUzIdx19
 LRwhLf2h6/49/33rblwJ+bEf3WPQcEA8TTfSXLe778x2uMDlX2FghsnODmOkgTftlJX51leL/
 9GrYLOzBMKdZfDKCqpIT3KnFrcDS5Th7EYzquMXiVBJtAG6orUUOBHemzzu6+knUQqdUwiz59
 t2Rfh/oWuxk0Yo8J+qfhu2ej56KfRNmFSmT/711hurDWNjQ6PzNwB+9OW8xuZW/8Ca5fw9zgJ
 OGh+JPTCJxZ2WT1b5Q7KtL42oI2hv2Is2HveQImVvylndEqKYcaeiS92+JLxr6nG2FR4cdcrl
 JrUSdrn3FVlllmTjzkgm2ZGnmrSZPOYIban3MHKpy1cbKvcCKUIvXQAHVti8MSbPhtDC4JT/a
 LqM10pDfNp68xgKM3mtTrLt/fU6F1RPRjjSt19aqOTxiiG/SrHHOtuPywH+s0Hp90jF3KtlWD
 QhylS+8EFkMs6RrtkR1e8rJWVZQ4ipTbDYcJvcDAVOEQfk/cF5O9eRfKqZu2Rc0Qg+/74xDHj
 pO7f1yO9TRvePuqIIUvXLZ/nFQsMpQAcZSXxrGBGYWi05ZH2DdcpbuuTjSH4R1r+uOIG9NAKZ
 zstGidjpRNXBsmo4pKtwmr1lGKyQXMmVRenBUV7FM8/FvEOaQS+iv2c2j8v+Zoxf4cKEO3qXS
 MVf/Uv9Hbxw3l56Ji/Fl870T3aTv8j/QY6jFLv+/sw1TEZ52qAAHdHBgy1mrHIs2a5CpNdFtn
 QZiY8t33aN3zAupVzJ6jCKiyBbbsWHEueruCKS1Hd1EB08am0XIotFhMfni+wTgyThfw2+5Nj
 sf52CkAc89KJa46vgwagXmi9j3nxCMqG6b9Cr1R2pkzcH26WB06bn/E9W5DcZmDpZ7IAWLtmp
 tHolIR19WOoEGS6l1ZzelPfCQ5H6/P2ALeOmdxn4wOpq71OqyHgVxtfk+0PIpC5mUdk0Hfnvk
 KARTmau/OHt/kf7TjJpZoFOEj6taTyMV8wiCYTbW8CT55R6ylD0CmkGTnsdOOG+gPzK2+jfcR
 hTw9v/S1n/q8E9MhAPX6gICmZMGB/0cbrTPEE79qPpUWaPnytcahcxZQu+z6CU5PqyB7em5EQ
 WvYZPCzmpHjz8dgGPZ4yOGG5cfGfqAZHqClvUWqUIbC4CmFoVsI7p78m01K3JXnBDGAI0Fziy
 efORhuH+fi6Jw9wVdGCc8uhp+F8NgwwY5ReE2Zi+E0Hfi7WLoKTRtdLHKyeKbqW1vtWtAfwPT
 nFxSAUKB0HSduP2YspIBu2Go+AMb7wlbu9Y6g2+ZTIaOU1LRgUCZ6RMJls2vPZHj0LGZM+lIN
 5jk566/IbJYaoB1703VTt6zPbGSZUoHrxtx3w33MNYW/QsZK46VWAdFQH6EjlzwFdPrug==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 31 Oct 2025 18:58:50 +0100

A pointer was assigned to a variable. The same pointer was used for
the destination parameter of a memcpy() call.
This function is documented in the way that the same value is returned.
Thus convert two separate statements into a direct variable assignment for
the return value from a memory copy action.

The source code was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/fpga/stratix10-soc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
index 0a295ccf1644..2e1167668ca8 100644
=2D-- a/drivers/fpga/stratix10-soc.c
+++ b/drivers/fpga/stratix10-soc.c
@@ -257,8 +257,7 @@ static int s10_send_buf(struct fpga_manager *mgr, cons=
t char *buf, size_t count)
=20
 	xfer_sz =3D count < SVC_BUF_SIZE ? count : SVC_BUF_SIZE;
=20
-	svc_buf =3D priv->svc_bufs[i].buf;
-	memcpy(svc_buf, buf, xfer_sz);
+	svc_buf =3D memcpy(priv->svc_bufs[i].buf, buf, xfer_sz);
 	ret =3D s10_svc_send_msg(priv, COMMAND_RECONFIG_DATA_SUBMIT,
 			       svc_buf, xfer_sz);
 	if (ret < 0) {
=2D-=20
2.51.1


